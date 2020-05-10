Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 703CF1CCB70
	for <lists+netfilter-devel@lfdr.de>; Sun, 10 May 2020 15:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbgEJNxW (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 10 May 2020 09:53:22 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:44859 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729037AbgEJNxV (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 10 May 2020 09:53:21 -0400
Received: from dimstar.local.net (n175-34-64-112.sun1.vic.optusnet.com.au [175.34.64.112])
        by mail104.syd.optusnet.com.au (Postfix) with SMTP id 529D5820FBD
        for <netfilter-devel@vger.kernel.org>; Sun, 10 May 2020 23:53:18 +1000 (AEST)
Received: (qmail 15568 invoked by uid 501); 10 May 2020 13:53:17 -0000
From:   Duncan Roe <duncan_roe@optusnet.com.au>
To:     pablo@netfilter.org
Cc:     netfilter-devel@vger.kernel.org
Subject: [PATCH libnetfilter_queue 0/1] pktb_alloc2()
Date:   Sun, 10 May 2020 23:53:16 +1000
Message-Id: <20200510135317.15526-1-duncan_roe@optusnet.com.au>
X-Mailer: git-send-email 2.14.5
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=QIgWuTDL c=1 sm=1 tr=0
        a=keeXcwCgVCrAuxOn72dlvA==:117 a=keeXcwCgVCrAuxOn72dlvA==:17
        a=sTwFKg_x9MkA:10 a=RSmzAf-M6YYA:10 a=G6kkh4doCZJfpJZuxiwA:9
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This iteration implements delayed data copy.
It obviates the need to explain to the users that they need to do their own
memcpy() and supply an 'extra' argument as suggested in regard to pktb_setup().

The user can examine data and decide whether a mangle is needed without
having done a memcpy() even if the mangle lengthens the packet.

examples/nf-queue.c is still to be done.

Duncan Roe (1):
  src: add pktb_alloc2() and pktb_head_size()

 fixmanpages.sh                       |   6 +-
 include/libnetfilter_queue/pktbuff.h |   4 +
 src/extra/ipv4.c                     |   8 +-
 src/extra/ipv6.c                     |   8 +-
 src/extra/pktbuff.c                  | 213 +++++++++++++++++++++++++++++------
 src/extra/tcp.c                      |  18 +++
 src/extra/udp.c                      |  18 +++
 src/internal.h                       |   2 +
 src/nlmsg.c                          |  14 ++-
 9 files changed, 245 insertions(+), 46 deletions(-)

--
2.14.5

