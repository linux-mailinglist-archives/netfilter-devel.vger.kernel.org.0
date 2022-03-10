Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D58DA4D46A5
	for <lists+netfilter-devel@lfdr.de>; Thu, 10 Mar 2022 13:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241940AbiCJMSw (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 10 Mar 2022 07:18:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236215AbiCJMSv (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 10 Mar 2022 07:18:51 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0959C30F4A
        for <netfilter-devel@vger.kernel.org>; Thu, 10 Mar 2022 04:17:50 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1nSHjo-0003bK-TL; Thu, 10 Mar 2022 13:17:48 +0100
Date:   Thu, 10 Mar 2022 13:17:48 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Phil Sutter <phil@nwl.cc>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
Subject: Re: [iptables RFC 1/2] libxtables: Implement notargets hash table
Message-ID: <20220310121748.GA13772@breakpoint.cc>
References: <20220304131944.30801-1-phil@nwl.cc>
 <20220304131944.30801-2-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304131944.30801-2-phil@nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Phil Sutter <phil@nwl.cc> wrote:
> +static void notargets_hlist_insert(const char *name)
> +{
> +	struct notarget *cur;
> +
> +	if (!name)
> +		return;
> +
> +	cur = xtables_malloc(sizeof(*cur) + strlen(name) + 1);
> +	cur->name[0] = '\0';
> +	strcat(cur->name, name);

strcpy seems more readable than strcat here.
Other than that this looks good to me.
