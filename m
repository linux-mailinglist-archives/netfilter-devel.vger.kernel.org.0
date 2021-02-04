Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3480C30E2B2
	for <lists+netfilter-devel@lfdr.de>; Wed,  3 Feb 2021 19:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbhBCSnP (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 3 Feb 2021 13:43:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbhBCSnO (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 3 Feb 2021 13:43:14 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64800C0613D6
        for <netfilter-devel@vger.kernel.org>; Wed,  3 Feb 2021 10:42:34 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1l7N6m-0005wU-Uq; Wed, 03 Feb 2021 19:42:33 +0100
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nft 1/3] testcases: move two dump files to correct location
Date:   Wed,  3 Feb 2021 19:42:25 +0100
Message-Id: <20210203184227.32208-1-fw@strlen.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210203184150.32145-1-fw@strlen.de>
References: <20210203184150.32145-1-fw@strlen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The test cases were moved but the dumps remained in the old location.

Fixes: eb14363d44cea5 ("tests: shell: move chain priority and policy to chain folder")
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 .../dumps/0031priority_variable_0.nft}                            | 0
 .../dumps/0035policy_variable_0.nft}                              | 0
 2 files changed, 0 insertions(+), 0 deletions(-)
 rename tests/shell/testcases/{nft-f/dumps/0021priority_variable_0.nft => chains/dumps/0031priority_variable_0.nft} (100%)
 rename tests/shell/testcases/{nft-f/dumps/0025policy_variable_0.nft => chains/dumps/0035policy_variable_0.nft} (100%)

diff --git a/tests/shell/testcases/nft-f/dumps/0021priority_variable_0.nft b/tests/shell/testcases/chains/dumps/0031priority_variable_0.nft
similarity index 100%
rename from tests/shell/testcases/nft-f/dumps/0021priority_variable_0.nft
rename to tests/shell/testcases/chains/dumps/0031priority_variable_0.nft
diff --git a/tests/shell/testcases/nft-f/dumps/0025policy_variable_0.nft b/tests/shell/testcases/chains/dumps/0035policy_variable_0.nft
similarity index 100%
rename from tests/shell/testcases/nft-f/dumps/0025policy_variable_0.nft
rename to tests/shell/testcases/chains/dumps/0035policy_variable_0.nft
-- 
2.26.2

