Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84A65130DD9
	for <lists+netfilter-devel@lfdr.de>; Mon,  6 Jan 2020 08:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgAFHJ3 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 6 Jan 2020 02:09:29 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:45164 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726569AbgAFHJ3 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 6 Jan 2020 02:09:29 -0500
Received: from dimstar.local.net (n122-110-44-45.sun2.vic.optusnet.com.au [122.110.44.45])
        by mail105.syd.optusnet.com.au (Postfix) with SMTP id EB2013A271C
        for <netfilter-devel@vger.kernel.org>; Mon,  6 Jan 2020 18:09:16 +1100 (AEDT)
Received: (qmail 4744 invoked by uid 501); 6 Jan 2020 07:09:15 -0000
From:   Duncan Roe <duncan_roe@optusnet.com.au>
To:     pablo@netfilter.org
Cc:     netfilter-devel@vger.kernel.org
Subject: [PATCH RFC libnetfilter_queue 0/1] Make usable man pages
Date:   Mon,  6 Jan 2020 18:09:14 +1100
Message-Id: <20200106070915.4700-1-duncan_roe@optusnet.com.au>
X-Mailer: git-send-email 2.14.5
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
        a=4DzML1vCOQ6Odsy8BUtSXQ==:117 a=4DzML1vCOQ6Odsy8BUtSXQ==:17
        a=Jdjhy38mL1oA:10 a=RSmzAf-M6YYA:10 a=yhr0tdMM4F9ZTAK7YRcA:9
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

fixmanpages.sh generates a top-level man page file tree such that man/man3
contains an entry for every documented nfq function. This is what users expect.

See main commit for how fixmanpages.sh works.

Itwould be nice to have "make" run "doxygen doxygen.cfg; ./fixmanpages.sh" and
"make install" install the man pages but I'm not yet that good with autotools.

There could be a similar script for libmnl.

Duncan Roe (1):
  doc: setup: Add shell script fixmanpages.sh to make usable man pages

 fixmanpages.sh | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100755 fixmanpages.sh

-- 
2.14.5

