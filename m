Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 215FF127570
	for <lists+netfilter-devel@lfdr.de>; Fri, 20 Dec 2019 06:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbfLTFyI (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 20 Dec 2019 00:54:08 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:45285 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725825AbfLTFyH (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 20 Dec 2019 00:54:07 -0500
Received: from dimstar.local.net (n122-110-44-45.sun2.vic.optusnet.com.au [122.110.44.45])
        by mail104.syd.optusnet.com.au (Postfix) with SMTP id A5AC2820003
        for <netfilter-devel@vger.kernel.org>; Fri, 20 Dec 2019 16:53:48 +1100 (AEDT)
Received: (qmail 24157 invoked by uid 501); 20 Dec 2019 05:53:48 -0000
From:   Duncan Roe <duncan_roe@optusnet.com.au>
To:     pablo@netfilter.org
Cc:     netfilter-devel@vger.kernel.org
Subject: [PATCH libnetfilter_queue 0/2] Add mangle functions for IPv6, IPv6/TCP and IPv6/UDP
Date:   Fri, 20 Dec 2019 16:53:46 +1100
Message-Id: <20191220055348.24113-1-duncan_roe@optusnet.com.au>
X-Mailer: git-send-email 2.14.5
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
        a=4DzML1vCOQ6Odsy8BUtSXQ==:117 a=4DzML1vCOQ6Odsy8BUtSXQ==:17
        a=pxVhFHJ0LMsA:10 a=RSmzAf-M6YYA:10 a=uRtfhzloAAAA:20
        a=Iuy8h-huI91oo4frHYsA:9 a=ubDO4clxTgye4MFiUn6k:22
        a=pHzHmUro8NiASowvMSCR:22 a=n87TN5wuljxrRezIQYnT:22
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

As before, the nfq6 testbed program exercises the new functions. nfq6 is part of
https://github.com/duncan-roe/nfq

The TODO item in src/extra/checksum.c is because the pseudo-header used in
udp & tcp checksums uses destination address from forwarding header if there
is one. Not a big deal for now, I would say.

Duncan Roe (2):
  src: more IPv6 checksum fixes
  src: add mangle functions for IPv6, IPv6/TCP and IPv6/UDP

 .../libnetfilter_queue/libnetfilter_queue_ipv6.h   |  1 +
 .../libnetfilter_queue/libnetfilter_queue_tcp.h    |  1 +
 .../libnetfilter_queue/libnetfilter_queue_udp.h    |  1 +
 src/extra/checksum.c                               | 10 +++---
 src/extra/ipv6.c                                   | 29 ++++++++++++++++
 src/extra/tcp.c                                    | 40 ++++++++++++++++++++++
 src/extra/udp.c                                    | 39 +++++++++++++++++++++
 7 files changed, 116 insertions(+), 5 deletions(-)

--
2.14.5

