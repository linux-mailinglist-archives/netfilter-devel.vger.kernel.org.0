Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1267D107CEF
	for <lists+netfilter-devel@lfdr.de>; Sat, 23 Nov 2019 06:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfKWFRN (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 23 Nov 2019 00:17:13 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:54507 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726638AbfKWFRN (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 23 Nov 2019 00:17:13 -0500
Received: from dimstar.local.net (n122-110-44-45.sun2.vic.optusnet.com.au [122.110.44.45])
        by mail105.syd.optusnet.com.au (Postfix) with SMTP id 48C573A185D
        for <netfilter-devel@vger.kernel.org>; Sat, 23 Nov 2019 16:16:57 +1100 (AEDT)
Received: (qmail 18350 invoked by uid 501); 23 Nov 2019 05:16:57 -0000
From:   Duncan Roe <duncan_roe@optusnet.com.au>
To:     pablo@netfilter.org
Cc:     netfilter-devel@vger.kernel.org
Subject: [PATCH libnetfilter_queue 0/1] src: Comment-out code not needed since Linux 3.8 in examples/nf-queue.c
Date:   Sat, 23 Nov 2019 16:16:56 +1100
Message-Id: <20191123051657.18308-1-duncan_roe@optusnet.com.au>
X-Mailer: git-send-email 2.14.5
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0
        a=4DzML1vCOQ6Odsy8BUtSXQ==:117 a=4DzML1vCOQ6Odsy8BUtSXQ==:17
        a=MeAgGD-zjQ4A:10 a=RSmzAf-M6YYA:10 a=FDdAsoSCZBkJDyaGnf4A:9
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This is the first in what I expect will be a number of patches to
examples/nf-queue.c as I update the documentation and maybe introduce new
helper functions.
An aspirational goal is to have all netfilter functions in nf-queue.c be
documented in the libnetfilter_queue web page.

Duncan Roe (1):
  src: Comment-out code not needed since Linux 3.8 in
    examples/nf-queue.c

 examples/nf-queue.c | 48 +++++++++++++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 23 deletions(-)

-- 
2.14.5

