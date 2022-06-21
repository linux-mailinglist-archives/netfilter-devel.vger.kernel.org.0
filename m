Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 402E4553205
	for <lists+netfilter-devel@lfdr.de>; Tue, 21 Jun 2022 14:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbiFUM2V (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 21 Jun 2022 08:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350055AbiFUM2T (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 21 Jun 2022 08:28:19 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B80D2BD9
        for <netfilter-devel@vger.kernel.org>; Tue, 21 Jun 2022 05:28:17 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1o3czO-00033I-Nc
        for netfilter-devel@vger.kernel.org; Tue, 21 Jun 2022 14:28:14 +0200
Date:   Tue, 21 Jun 2022 14:28:14 +0200
From:   Florian Westphal <fw@strlen.de>
To:     netfilter-devel <netfilter-devel@vger.kernel.org>
Subject: large number of sparse warnings in nf_flow_table_offload
Message-ID: <20220621122814.GA26235@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hello,

nf_flow_table_offload.c generates a large number of sparse
warnings.

There are two possible approaches:

1. Use __u32 instead of __be32 in helpers:
static void flow_offload_mangle(struct flow_action_entry *entry,
		                enum flow_action_mangle_base htype, u32 offset,
-                               const __be32 *value, const __be32 *mask)
+                               const __u32 *value, const __u32 *mask)

... and so on.

Or, use __be32/16 consistently.

Problem is that the underlying struct flow_action_entry defines
mask/val as __u32, but it really seems to expect __be32.

Whats the preference here?
I would lean towards option two, i.e. pretend that
struct flow_action_entry *really* uses __be32, it makes more sense to me
from a logical point of view, even though this will need more changes.

I can use objdump to make sure that this doesn't result in any changes
in the compiled binary.

Thanks,
Florian
