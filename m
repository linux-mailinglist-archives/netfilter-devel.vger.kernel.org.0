Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C00551955
	for <lists+netfilter-devel@lfdr.de>; Mon, 24 Jun 2019 19:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732327AbfFXRKp (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 24 Jun 2019 13:10:45 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:51480 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732326AbfFXRKo (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 24 Jun 2019 13:10:44 -0400
Received: from localhost ([::1]:36338 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1hfSUN-0003ZP-PM; Mon, 24 Jun 2019 19:10:43 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [nft PATCH 0/2] Improve a few minor JSON glitches
Date:   Mon, 24 Jun 2019 19:10:36 +0200
Message-Id: <20190624171038.24672-1-phil@nwl.cc>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

As suggested offline, print newline at end of JSON output (patch 1) and
don't ignore -j flag if JSON support is not compiled-in - bail instead
(patch 2).

Phil Sutter (2):
  json: Print newline at end of list output
  main: Bail if non-available JSON was requested

 src/json.c | 2 ++
 src/main.c | 3 +++
 2 files changed, 5 insertions(+)

-- 
2.21.0

