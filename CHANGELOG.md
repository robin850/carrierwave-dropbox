# Changelog

## 1.2.1 (February 24, 2014)

* Use the uploader's store_path instead of the root

## 1.2.0 (January 12, 2014)

* Make the `dropbox_client` method public

  You can now easily access to the `dropbox_client` method to get
  information about the current connection or check if the latter is
  active or not.

* Use the root path instead of the `Public` directory by default

## 1.1.1 (October 5, 2013)

* Fix deletion when using app_folder accounts

## 1.1.0 (September 22, 2013)

* Make the gem working with "app_folder" applications.

  Correct the returned URL for applications which are not "dropbox" ones
  since they are not only accessible publicly.

  Resolve #1

## 1.0.2 (August 3, 2013)

* Add a rescue block for `DropboxError` since CarrierWave is trying to
delete all specified versions of a file even if they do not exist.

## 1.0.1 (August 2, 2013)

* Ensure resource edition works

## 1.0.0 (August 2, 2013)

* First release
