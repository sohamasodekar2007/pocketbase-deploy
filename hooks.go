package main

import (
    "os"

    "github.com/pocketbase/pocketbase"
    "github.com/pocketbase/pocketbase/tools/filesystem/s3"
)

func init() {
    // This will be called during PocketBase initialization
    pocketbase.Bootstrap.AddBeforeStartHook(func(app *pocketbase.PocketBase) error {

        // Set Cloudflare R2 as the upload storage
        app.SetUploadStorage(s3.NewStorage(s3.Options{
            Bucket:    "edunexus-pocketbase-uploads",
            Region:    "auto", // R2 accepts 'auto'
            Endpoint:  "https://76121685fceeecf363fc87bb0ba16c0c.r2.cloudflarestorage.com",
            AccessKey: "0b965c553833d973e62fb8c3ccf14a7a",
            Secret:    "2aa79062d526299b1fee84104b150ac160e065b764ce1a68b18f5f72c9131876",
        }))

        return nil
    })
}
