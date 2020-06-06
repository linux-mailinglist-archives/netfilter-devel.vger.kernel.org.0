Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 152071F0541
	for <lists+netfilter-devel@lfdr.de>; Sat,  6 Jun 2020 07:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgFFFZO (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 6 Jun 2020 01:25:14 -0400
Received: from mail109.syd.optusnet.com.au ([211.29.132.80]:36406 "EHLO
        mail109.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726157AbgFFFZN (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 6 Jun 2020 01:25:13 -0400
Received: from dimstar.local.net (n175-34-64-112.sun1.vic.optusnet.com.au [175.34.64.112])
        by mail109.syd.optusnet.com.au (Postfix) with SMTP id D82E6D79CE3
        for <netfilter-devel@vger.kernel.org>; Sat,  6 Jun 2020 15:25:11 +1000 (AEST)
Received: (qmail 27465 invoked by uid 501); 6 Jun 2020 05:25:10 -0000
From:   Duncan Roe <duncan_roe@optusnet.com.au>
To:     fw@strlen.de, pablo@netfilter.org
Cc:     netfilter-devel@vger.kernel.org
Subject: [PATCH libnetfilter_queue 0/1] URGENT: libnetfilter_queue-1.0.4 fails to build
Date:   Sat,  6 Jun 2020 15:25:09 +1000
Message-Id: <20200606052510.27423-1-duncan_roe@optusnet.com.au>
X-Mailer: git-send-email 2.14.5
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
        a=keeXcwCgVCrAuxOn72dlvA==:117 a=keeXcwCgVCrAuxOn72dlvA==:17
        a=nTHF0DUjJn0A:10 a=RSmzAf-M6YYA:10 a=giKtE7Rn05mRxfI6FCYA:9
        a=8ikClVe_5GEA:10
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

-- 
2.14.5

