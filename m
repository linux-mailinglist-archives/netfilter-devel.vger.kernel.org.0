Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3697369AC34
	for <lists+netfilter-devel@lfdr.de>; Fri, 17 Feb 2023 14:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjBQNN3 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 17 Feb 2023 08:13:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjBQNN2 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 17 Feb 2023 08:13:28 -0500
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD5F2FCFB
        for <netfilter-devel@vger.kernel.org>; Fri, 17 Feb 2023 05:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
        s=mail2022; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=oFqBTm1oz6+lK8l02UP5eCAy/T3YxYE54D+hcOH71uA=; b=dhIWs8ZbAPGH3WDIwKVCZ8JpG6
        hyHxW9cqqZt5iqXkpCI1j2KbjAngHe/Dd6Mv0Gw6L359fQaAVafxtZ60jAncZfzuEcUiwHb+tIAcM
        c4Kek8MHzAwkATVpOQutiFXAy2w/Y5cmsj6g5HLPcS9kLV5gVaIUCyws/ODQP9LKFPOI5YUomcB50
        GrgDTzno/4WD6dr6BnI9aDClpLpr13eFb/Kl+p6jU+lmBe9Zq93GeH0UwbNnBYuNxPTv5sigx5rw4
        yHM3luT6Ioc4h7IcTnTB7uXqcdOykfqKOfZubskojrdg75neh4zF/ldyedKERacOOF6CFcCgOVgMK
        ZUU8gxMQ==;
Received: from localhost ([::1] helo=xic)
        by orbyte.nwl.cc with esmtp (Exim 4.94.2)
        (envelope-from <phil@nwl.cc>)
        id 1pT0YE-0001bO-G4
        for netfilter-devel@vger.kernel.org; Fri, 17 Feb 2023 14:13:22 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH] tests: CLUSTERIP: Drop test file
Date:   Fri, 17 Feb 2023 14:13:13 +0100
Message-Id: <20230217131313.1173-1-phil@nwl.cc>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The extension was removed from kernel, do not test for it anymore. Keep
the code alive though, to not break existing setups.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 extensions/libipt_CLUSTERIP.t | 4 ----
 1 file changed, 4 deletions(-)
 delete mode 100644 extensions/libipt_CLUSTERIP.t

diff --git a/extensions/libipt_CLUSTERIP.t b/extensions/libipt_CLUSTERIP.t
deleted file mode 100644
index 30b80167a6223..0000000000000
--- a/extensions/libipt_CLUSTERIP.t
+++ /dev/null
@@ -1,4 +0,0 @@
-:INPUT
--d 10.31.3.236/32 -i lo -j CLUSTERIP --new --hashmode sourceip --clustermac 01:AA:7B:47:F7:D7 --total-nodes 2 --local-node 0 --hash-init 1;=;FAIL
--d 10.31.3.236/32 -i lo -j CLUSTERIP --new --hashmode sourceip --clustermac 01:AA:7B:47:F7:D7 --total-nodes 2 --local-node 1 --hash-init 1;=;OK;LEGACY
--d 10.31.3.236/32 -i lo -j CLUSTERIP --new --hashmode sourceip --clustermac 01:AA:7B:47:F7:D7 --total-nodes 2 --local-node 2 --hash-init 1;=;OK;LEGACY
-- 
2.38.0

