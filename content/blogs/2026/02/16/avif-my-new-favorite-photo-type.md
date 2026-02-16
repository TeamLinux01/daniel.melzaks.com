+++
title = 'AVIF, my new favorite photo type'
date = 2026-02-16T10:13:00-05:00
draft = false
+++

It had been awhile since I have felt up to working with my server or my computers at home, let alone write about it. This past year has been a huge struggle for me and thankfully I have been surrounded by wonderful people in my life to life up my spirits. God bless each of my family members and friends.

I am starting to feel a bit more up to tackling maintenance and projects I have been putting off, so let us get right down to it.

I am a big fan of open standards and open source technology, so when I found out I could use the [AV1 video coding format](https://en.wikipedia.org/wiki/AV1) to convert photos, I was very curious to see what would happen. The photo format is called [AVIF](https://en.wikipedia.org/wiki/AVIF) and you can use [ImageMagick](https://en.wikipedia.org/wiki/ImageMagick)'s mogrify script to change the format of one photo to another, such as TIF to AVIF with the resulting photo will end in a .avif file extension type.

My Mom would scan and save as many of the photos she had physically in the TIF format, as it preserved the most detail at the time from what I understood; the time frame was early 2000's. When she passed away, I wanted to keep and maintain the photos she was curating, making sure that duplicates and corrupted files were removed. I did find that several of the 54 thousand plus pictures had bit corruption in some way, so remember that you can't trust your medium and if you really care about data, you have to use a filesystem that checksums the data, such as ZFS.

TIF files are very large in comparison to JPEG files and with how many photos she had, the space it took up about 908.56GiB of storage with 58,400 files in the Pictures folder I have on my server according to a space managing program [dua-cli](https://github.com/Byron/dua-cli) on a ZFS snapshot before I made changes. The current space of that same folder is now 8.09GiB with 57,365 files; again with some deleted corrupted files, thumbnails and a couple of none photo files I missed when cleaning.

To give a real example of the differences between one of the TIF files and the converted AVIF, here is a real photo that she took and I converted:

![TIF photo](/images/blogs/avif-my-new-favorite-photo-type/1974_Jul_16_River_Geneva_Switzer.tif "TIF photo")

![AVIF photo](/images/blogs/avif-my-new-favorite-photo-type/1974_Jul_16_River_Geneva_Switzer.avif "AVIF photo")

The photo is 2848x2112 (6.0MP) pixels. TIF file is uncompressed and the size is 17.2 MiB. AVIF is compressed and the size is 44.9 KiB.

I know it is an unfair comparison to show the size differences between an uncompressed and compressed file, but I want to point out that I only care about the overall picture look in the end. While the AVIF is ever so slightly softer in the image, I personally think it looks better. If my Mom could have used AVIF, I think she would have either agreed that the compressed versions are good enough or would have picked to use lossless encoding anyways, which would probably be around the same file size overall as the TIF.

I thought it was fascinating and AVIF does significantly shrink JPEG files, too. There was a 2.6MB photo that was converted down to 413.8KB and I could not tell the difference between the two.

I would like to do the same kind of conversions with my video files, but that is a bit more time consuming and I am trying to figure out the best container structure. I did convert some MPEG videos to AV1 in a [MKV container](https://en.wikipedia.org/wiki/Matroska), but I want to go full [WebM](https://en.wikipedia.org/wiki/AV1#Supported_container_formats) at some point and that has not yet been formally sanctioned plus I heard that it has issues with subtitles as well.

Looking forward to the future and what [AV2](https://en.wikipedia.org/wiki/AV2) will bring us. I do not mind waiting for great things to come together.
