Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E850B7AFE45
	for <lists+netfilter-devel@lfdr.de>; Wed, 27 Sep 2023 10:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjI0I0R (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 27 Sep 2023 04:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbjI0IZu (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 27 Sep 2023 04:25:50 -0400
Received: from ganesha.gnumonks.org (unknown [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC5E13A;
        Wed, 27 Sep 2023 01:25:22 -0700 (PDT)
Received: from [78.30.34.192] (port=39392 helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pablo@gnumonks.org>)
        id 1qlPqu-00B95F-Su; Wed, 27 Sep 2023 10:25:02 +0200
Date:   Wed, 27 Sep 2023 10:24:59 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     joao@overdrivepizza.com
Cc:     netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kadlec@netfilter.org, fw@strlen.de, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        rkannoth@marvell.com, wojciech.drewek@intel.com,
        steen.hegenlund@microhip.com, keescook@chromium.org,
        Joao Moreira <joao.moreira@intel.com>
Subject: Re: [PATCH v2 0/2] Prevent potential write out of bounds
Message-ID: <ZRPm2/KsmDmFTOcS@calendula>
References: <20230927020221.85292-1-joao@overdrivepizza.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230927020221.85292-1-joao@overdrivepizza.com>
X-Spam-Score: -1.9 (-)
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Sep 26, 2023 at 07:02:19PM -0700, joao@overdrivepizza.com wrote:
> From: Joao Moreira <joao.moreira@intel.com>
> 
> The function flow_rule_alloc in net/core/flow_offload.c [2] gets an
> unsigned int num_actions (line 10) and later traverses the actions in
> the rule (line 24) setting hw.stats to FLOW_ACTION_HW_STATS_DONT_CARE.
> 
> Within the same file, the loop in the line 24 compares a signed int
> (i) to an unsigned int (num_actions), and then uses i as an array
> index. If an integer overflow happens, then the array within the loop
> is wrongly indexed, causing a write out of bounds.
> 
> After checking with maintainers, it seems that the front-end caps the
> maximum value of num_action, thus it is not possible to reach the given
> write out of bounds, yet, still, to prevent disasters it is better to
> fix the signedness here.
> 
> Similarly, also it is also good to ensure that an overflow won't happen
> in net/netfilter/nf_tables_offload.c's function nft_flow_rule_create by
> making the variable unsigned and ensuring that it returns an error if
> its value reaches UINT_MAX.
> 
> This issue was observed by the commit author while reviewing a write-up
> regarding a CVE within the same subsystem [1].

I keep spinning around this, this is not really an issue.

No frontend uses this amount of actions.

Probably cap this to uint16_t because 2^16 actions is more than
sufficient by now.
