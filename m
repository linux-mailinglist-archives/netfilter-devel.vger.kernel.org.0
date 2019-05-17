Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2AE2209F
	for <lists+netfilter-devel@lfdr.de>; Sat, 18 May 2019 01:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbfEQXAu (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 17 May 2019 19:00:50 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:57054 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726519AbfEQXAu (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 17 May 2019 19:00:50 -0400
Received: from localhost ([::1]:41910 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1hRlqK-0007GS-Pz; Sat, 18 May 2019 01:00:48 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Eric Garver <e@erig.me>, netfilter-devel@vger.kernel.org,
        Florian Westphal <fw@strlen.de>
Subject: [nft PATCH 0/3] Resolve cache update woes
Date:   Sat, 18 May 2019 01:00:30 +0200
Message-Id: <20190517230033.25417-1-phil@nwl.cc>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This series implements a fix for situations where a cache update removes
local (still uncommitted) items from cache leading to spurious errors
afterwards.

The series is based on Eric's "src: update cache if cmd is more
specific" patch which is still under review but resolves a distinct
problem from the one addressed in this series.

The first patch improves Eric's patch a bit. If he's OK with my change,
it may very well be just folded into his.

Phil Sutter (3):
  src: Improve cache_needs_more() algorithm
  libnftables: Keep list of commands in nft context
  src: Restore local entries after cache update

 include/nftables.h |  1 +
 src/libnftables.c  | 21 +++++------
 src/rule.c         | 91 +++++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 96 insertions(+), 17 deletions(-)

-- 
2.21.0

