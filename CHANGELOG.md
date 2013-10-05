# Changelog

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
