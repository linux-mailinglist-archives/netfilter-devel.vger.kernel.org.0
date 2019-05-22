Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7303726DC3
	for <lists+netfilter-devel@lfdr.de>; Wed, 22 May 2019 21:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730081AbfEVTo0 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 22 May 2019 15:44:26 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:44738 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730513AbfEVToH (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 22 May 2019 15:44:07 -0400
Received: from localhost ([::1]:57826 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1hTX9h-0003SM-Fk; Wed, 22 May 2019 21:44:05 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org, Eric Garver <eric@garver.life>
Subject: [nft PATCH v2 0/3] Resolve cache update woes
Date:   Wed, 22 May 2019 21:44:03 +0200
Message-Id: <20190522194406.16827-1-phil@nwl.cc>
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

Changes since v1:
- As suggested by Eric, I took his patch and folded my enhancement
  (former patch 1) into his one.
- Changed patch 3 to include Eric's fix.

Eric Garver (1):
  src: update cache if cmd is more specific

Phil Sutter (2):
  libnftables: Keep list of commands in nft context
  src: Restore local entries after cache update

 include/nftables.h                            |  2 +
 src/libnftables.c                             | 21 ++---
 src/rule.c                                    | 93 +++++++++++++++++++
 .../shell/testcases/cache/0003_cache_update_0 | 14 +++
 4 files changed, 119 insertions(+), 11 deletions(-)

-- 
2.21.0

