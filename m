Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30DFE42A3D4
	for <lists+netfilter-devel@lfdr.de>; Tue, 12 Oct 2021 14:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236312AbhJLMI3 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 12 Oct 2021 08:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233045AbhJLMI2 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 12 Oct 2021 08:08:28 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD96C061570;
        Tue, 12 Oct 2021 05:06:27 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1maGY2-0006eg-3h; Tue, 12 Oct 2021 14:06:22 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     lvs-devel@vger.kernel.org, ja@ssi.bg, horms@verge.net.au,
        Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next 0/4] netfilter: ipvs: remove unneeded hook wrappers
Date:   Tue, 12 Oct 2021 14:06:04 +0200
Message-Id: <20211012120608.21827-1-fw@strlen.de>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This series reduces the number of different hook function
implementations by merging the ipv4 and ipv6 hooks into
common code.

selftests/netfilter/ipvs.sh passes.

Florian Westphal (4):
  netfilter: ipvs: prepare for hook function reduction
  netfilter: ipvs: remove unneeded output wrappers
  netfilter: ipvs: remove unneeded input wrappers
  netfilter: ipvs: merge ipv4 + ipv6 icmp reply handlers

 net/netfilter/ipvs/ip_vs_core.c | 166 ++++++--------------------------
 1 file changed, 32 insertions(+), 134 deletions(-)

-- 
2.32.0

