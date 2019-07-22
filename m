Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8C8570533
	for <lists+netfilter-devel@lfdr.de>; Mon, 22 Jul 2019 18:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbfGVQQD (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 22 Jul 2019 12:16:03 -0400
Received: from mx1.riseup.net ([198.252.153.129]:37692 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728467AbfGVQQD (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 22 Jul 2019 12:16:03 -0400
Received: from bell.riseup.net (bell-pn.riseup.net [10.0.1.178])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (verified OK))
        by mx1.riseup.net (Postfix) with ESMTPS id CB0F91B9A12;
        Mon, 22 Jul 2019 09:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1563812162; bh=FbZVk+hQl0e5WDX7N9KsrwDK3Y9yfhh3X3Ire8vxVRM=;
        h=To:From:Subject:Cc:Date:From;
        b=KuSkKAKI/Mo1MwCgtSPz4hg6e8j4GeoQBwPzHxC1b88qFw7m/WiA9miV1B7zfdLju
         tMzYG9+Kg8jQu2krjeGLbf7/+/lrEZHvyxqEitvcsGT/5oDocMC/jGboov7ydKQqsg
         x1Npkengf3faSnzU+lIZYY/+rlcA8HagFh1DrI/8=
X-Riseup-User-ID: CFC87A006DDF0AF0037AE31F0901BFD0D9C589CCF44EB6C9C6AB56A33F41A76F
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by bell.riseup.net (Postfix) with ESMTPSA id 29E2B222170;
        Mon, 22 Jul 2019 09:16:01 -0700 (PDT)
To:     netfilter-devel@vger.kernel.org
From:   Fernando Fernandez Mancera <ffmancera@riseup.net>
Subject: memleak when using "nft -f"
Openpgp: preference=signencrypt
Cc:     Phil Sutter <phil@nwl.cc>
Message-ID: <8d5745ef-5199-4754-55ee-22c6c5994341@riseup.net>
Date:   Mon, 22 Jul 2019 18:16:14 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

I have found a memleak when using "nft -f".

Example file (test-memleak):

add table ip foo
add chain ip foo bar {type filter hook input priority filter;}

# valgrind --leak-check=full nft -f test-memleak

==12624== Memcheck, a memory error detector
==12624== Copyright (C) 2002-2017, and GNU GPL'd, by Julian Seward et al.
==12624== Using Valgrind-3.14.0 and LibVEX; rerun with -h for copyright info
==12624== Command: nft -f policy_test
==12624==
==12624==
==12624== HEAP SUMMARY:
==12624==     in use at exit: 7 bytes in 1 blocks
==12624==   total heap usage: 59 allocs, 58 frees, 242,068 bytes allocated
==12624==
==12624== 7 bytes in 1 blocks are definitely lost in loss record 1 of 1
==12624==    at 0x483577F: malloc (vg_replace_malloc.c:299)
==12624==    by 0x4C4FDB9: strdup (strdup.c:42)
==12624==    by 0x488403D: xstrdup (utils.c:75)
==12624==    by 0x48A7C0F: nft_lex (scanner.l:641)
==12624==    by 0x489827B: nft_parse (parser_bison.c:5482)
==12624==    by 0x4889797: nft_parse_bison_filename (libnftables.c:395)
==12624==    by 0x4889797: nft_run_cmd_from_filename (libnftables.c:498)
==12624==    by 0x10A616: main (main.c:318)
==12624==
==12624== LEAK SUMMARY:
==12624==    definitely lost: 7 bytes in 1 blocks
==12624==    indirectly lost: 0 bytes in 0 blocks
==12624==      possibly lost: 0 bytes in 0 blocks
==12624==    still reachable: 0 bytes in 0 blocks
==12624==         suppressed: 0 bytes in 0 blocks
==12624==
==12624== For counts of detected and suppressed errors, rerun with: -v
==12624== ERROR SUMMARY: 1 errors from 1 contexts (suppressed: 0 from 0)

I have been trying to debug this but I was not able to find where is the
problem.
