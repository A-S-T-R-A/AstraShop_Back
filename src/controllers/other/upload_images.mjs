import multer from "multer";
import path from "path";
import fs from "fs";
import * as url from "url";

export const __dirname = url.fileURLToPath(new URL(".", import.meta.url));

const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    const folderPath = process.env.FILE_UPLOAD_PATH || path.join(__dirname, "");

    if (!fs.existsSync(folderPath)) {
      console.error("Folder does not exist");
    } else {
      cb(null, folderPath);
    }
  },
  filename: function (req, file, cb) {
    cb(
      null,
      file.fieldname + "-" + Date.now() + path.extname(file.originalname)
    );
  },
});

const uploader = multer({
  storage,
  limits: {
    fileSize: 1024 * 1024 * 5, // 5 MB
  },
  fileFilter: (req, file, cb) => {
    if (
      file.mimetype === "image/jpeg" ||
      file.mimetype === "image/png" ||
      file.mimetype === "image/svg+xml"
    ) {
      cb(null, true);
    } else {
      cb(null, false);

      if (!req.uploadError) {
        req.uploadError = "File type is not supported";
      }
    }
  },
});

const upload = uploader.array("images");

export async function uploadImages(req, res) {
  try {
    upload(req, res, (err) => {
      if (req.uploadError) {
        return res.status(400).json({ message: req.uploadError });
      }

      if (err) {
        if (err instanceof multer.MulterError) {
          switch (err.code) {
            case "LIMIT_FILE_SIZE":
              return res.status(400).json({
                message: "File size is too large. Max size is 5MB",
              });
          }
        } else {
          return res.sendStatus(500);
        }
      } else {
        return res
          .status(201)
          .json(
            req.files.map(
              (file) =>
                `${process.env.HOST}:${process.env.PORT}/uploads/${file.filename}`
            )
          );
      }
    });
  } catch (err) {
    return res.status(500);
  }
}
