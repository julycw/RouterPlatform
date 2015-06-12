package tools

import (
	"crypto/md5"
	"encoding/hex"
	"io"
)

func MD5(in string) string {
	hash := md5.New()
	hash.Write([]byte(in))
	return hex.EncodeToString(hash.Sum(nil))
}

func MD5File(file io.Reader) string {
	hash := md5.New()
	io.Copy(hash, file)
	return hex.EncodeToString(hash.Sum(nil))
}
