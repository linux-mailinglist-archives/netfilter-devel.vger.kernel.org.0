Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5A51046D9
	for <lists+netfilter-devel@lfdr.de>; Thu, 21 Nov 2019 00:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725878AbfKTXJ6 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 20 Nov 2019 18:09:58 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:55220 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725820AbfKTXJ6 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 20 Nov 2019 18:09:58 -0500
Received: from dimstar.local.net (n122-110-44-45.sun2.vic.optusnet.com.au [122.110.44.45])
        by mail105.syd.optusnet.com.au (Postfix) with SMTP id A5FF33A2127
        for <netfilter-devel@vger.kernel.org>; Thu, 21 Nov 2019 10:09:43 +1100 (AEDT)
Received: (qmail 5978 invoked by uid 501); 20 Nov 2019 23:09:42 -0000
Date:   Thu, 21 Nov 2019 10:09:42 +1100
From:   Duncan Roe <duncan_roe@optusnet.com.au>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Netfilter Development <netfilter-devel@vger.kernel.org>
Subject: Documentation question
Message-ID: <20191120230942.GA12786@dimstar.local.net>
Mail-Followup-To: Pablo Neira Ayuso <pablo@netfilter.org>,
        Netfilter Development <netfilter-devel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=G6BsK5s5 c=1 sm=1 tr=0
        a=4DzML1vCOQ6Odsy8BUtSXQ==:117 a=4DzML1vCOQ6Odsy8BUtSXQ==:17
        a=kj9zAlcOel0A:10 a=MeAgGD-zjQ4A:10 a=RSmzAf-M6YYA:10
        a=IvWv4juTdQUDZDDI2rcA:9 a=CjuIK1q_8ugA:10
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Pablo,

Deprecated nfq_set_queue_flags documents flag NFQA_CFG_F_FAIL_OPEN for kernel to
accept packets if the kernel queue gets full.

Does this still work with libmnl?I'm thinking we need a new "Library Setup
[CURRENT]" section to document available flags (including e.g. NFQA_CFG_F_GSO
that examples/nf-queue.c uses).

Maybe we need Attribute helper functions as well? (documentation *and* new
code).

Cheers ... Duncan.
