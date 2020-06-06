Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 852761F06F1
	for <lists+netfilter-devel@lfdr.de>; Sat,  6 Jun 2020 16:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgFFOZM (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 6 Jun 2020 10:25:12 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:58622 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726089AbgFFOZM (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 6 Jun 2020 10:25:12 -0400
Received: from dimstar.local.net (n175-34-64-112.sun1.vic.optusnet.com.au [175.34.64.112])
        by mail105.syd.optusnet.com.au (Postfix) with SMTP id 352C13A36BD
        for <netfilter-devel@vger.kernel.org>; Sun,  7 Jun 2020 00:25:09 +1000 (AEST)
Received: (qmail 6948 invoked by uid 501); 6 Jun 2020 14:25:08 -0000
From:   Duncan Roe <duncan_roe@optusnet.com.au>
To:     fw@strlen.de, pablo@netfilter.org
Cc:     netfilter-devel@vger.kernel.org
Subject: [PATCH libnetfilter_queue 0/1] URGENT: libnetfilter_queue-1.0.4 fails to build
Date:   Sun,  7 Jun 2020 00:25:07 +1000
Message-Id: <20200606142508.6906-1-duncan_roe@optusnet.com.au>
X-Mailer: git-send-email 2.14.5
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
        a=keeXcwCgVCrAuxOn72dlvA==:117 a=keeXcwCgVCrAuxOn72dlvA==:17
        a=nTHF0DUjJn0A:10 a=RSmzAf-M6YYA:10 a=WiEEQyG7nseCK6EDKxcA:9
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

'make' says: No rule to build ../fixmanpages.sh: stop
Maybe you can push out a re-release before anyone else notices?
Do what you must,

Cheers ... Duncan.

Duncan Roe (1):
  build: dist: Add fixmanpages.sh to distribution tree

 Makefile.am | 1 +
 1 file changed, 1 insertion(+)

v2: Move fixmanpages.sh into the doxygen directory
    Compare Slackware built package to v1: no significant diffs.
    (diffs are: "Generated on" lines in html files differ
                binary gzipped man pages differ, but zdiff compares equal)

-- 
2.14.5

