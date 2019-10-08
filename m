Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD2E3CF006
	for <lists+netfilter-devel@lfdr.de>; Tue,  8 Oct 2019 02:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729708AbfJHAuQ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 7 Oct 2019 20:50:16 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:39898 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729575AbfJHAuQ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 7 Oct 2019 20:50:16 -0400
Received: from dimstar.local.net (n122-110-44-45.sun2.vic.optusnet.com.au [122.110.44.45])
        by mail105.syd.optusnet.com.au (Postfix) with SMTP id 085BB364039
        for <netfilter-devel@vger.kernel.org>; Tue,  8 Oct 2019 11:49:49 +1100 (AEDT)
Received: (qmail 25675 invoked by uid 501); 8 Oct 2019 00:49:48 -0000
From:   Duncan Roe <duncan_roe@optusnet.com.au>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH libnetfilter_queue 0/5] clang and documentation updates
Date:   Tue,  8 Oct 2019 11:49:43 +1100
Message-Id: <20191008004948.25632-1-duncan_roe@optusnet.com.au>
X-Mailer: git-send-email 2.14.5
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=FNpr/6gs c=1 sm=1 tr=0
        a=4DzML1vCOQ6Odsy8BUtSXQ==:117 a=4DzML1vCOQ6Odsy8BUtSXQ==:17
        a=XobE76Q3jBoA:10 a=6tMkX_wzsTAUBDp-0rwA:9
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This series is a mixture of patches to enable clang build and correct / insert
doxygen comments. It ended up that way after git merges of local branches where
they were originally developed.

Hopefully they are all uncontroversial so can just be applied.

Duncan Roe (4):
  src: doc: Miscellaneous documentation updates
  src: Enable clang build
  src: Fix invalid conversion specifier
  src: doc: Minor fix

Pablo Neira Ayuso (1):
  doxygen: remove EXPORT_SYMBOL from the output

 doxygen.cfg.in           |   2 +-
 src/extra/ipv4.c         |  33 +++++----
 src/extra/ipv6.c         |  16 ++---
 src/extra/pktbuff.c      |  80 ++++++++++++----------
 src/extra/tcp.c          |  24 +++----
 src/extra/udp.c          |  53 +++++++--------
 src/internal.h           |   3 +-
 src/libnetfilter_queue.c | 173 +++++++++++++++++++++++------------------------
 src/nlmsg.c              |  63 ++++++++++-------
 9 files changed, 236 insertions(+), 211 deletions(-)

-- 
2.14.5

