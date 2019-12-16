Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D765311F556
	for <lists+netfilter-devel@lfdr.de>; Sun, 15 Dec 2019 03:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfLOCCj (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 14 Dec 2019 21:02:39 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:39251 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726865AbfLOCCj (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 14 Dec 2019 21:02:39 -0500
Received: from dimstar.local.net (n122-110-44-45.sun2.vic.optusnet.com.au [122.110.44.45])
        by mail104.syd.optusnet.com.au (Postfix) with SMTP id 2492C43F62A
        for <netfilter-devel@vger.kernel.org>; Sun, 15 Dec 2019 13:02:21 +1100 (AEDT)
Received: (qmail 13819 invoked by uid 501); 15 Dec 2019 02:02:20 -0000
Date:   Sun, 15 Dec 2019 13:02:20 +1100
From:   Duncan Roe <duncan_roe@optusnet.com.au>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Netfilter Development <netfilter-devel@vger.kernel.org>
Subject: Documentation question
Message-ID: <20191215020220.GA10616@dimstar.local.net>
Mail-Followup-To: Pablo Neira Ayuso <pablo@netfilter.org>,
        Netfilter Development <netfilter-devel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
        a=4DzML1vCOQ6Odsy8BUtSXQ==:117 a=4DzML1vCOQ6Odsy8BUtSXQ==:17
        a=kj9zAlcOel0A:10 a=pxVhFHJ0LMsA:10 a=RSmzAf-M6YYA:10
        a=KilSMQB6Bt7QXK_omFkA:9 a=CjuIK1q_8ugA:10 a=pHzHmUro8NiASowvMSCR:22
        a=nt3jZW36AmriUCFCBwmW:22
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Pablo,

In pktbuff.c, the doc for pktb_mangle states that "It is appropriate to use
pktb_mangle to change the MAC header".

This is not true. pktb_mangle always mangles from the network header onwards.

I can either:

Whithdraw the offending doc items

OR:

Adjust pktb_mangle to make the doc correct. This involves changing pktb_mangle,
nfq_ip_mangle and (soon) nfq_ip6_mangle. The changes would be a no-op for
AF_INET and AF_INET6 packet buffers.

What do you think?

Cheers ... Duncan.
