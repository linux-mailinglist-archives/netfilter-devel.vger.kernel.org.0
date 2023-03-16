Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5515C6BCE1C
	for <lists+netfilter-devel@lfdr.de>; Thu, 16 Mar 2023 12:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjCPL2S (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 16 Mar 2023 07:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjCPL2S (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 16 Mar 2023 07:28:18 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D4022DD6
        for <netfilter-devel@vger.kernel.org>; Thu, 16 Mar 2023 04:28:16 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1pclmG-0006Vw-Hd; Thu, 16 Mar 2023 12:28:12 +0100
Date:   Thu, 16 Mar 2023 12:28:12 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Kyuwon Shim <kyuwon.shim@alliedtelesis.co.nz>
Cc:     pablo@netfilter.org, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH v2] ulogd2: Avoid use after free in unregister on global
 ulogd_fds linked list
Message-ID: <ZBL9TEfTBqwoEZH5@strlen.de>
References: <1678233154187.35009@alliedtelesis.co.nz>
 <20230309012447.201582-1-kyuwon.shim@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309012447.201582-1-kyuwon.shim@alliedtelesis.co.nz>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Kyuwon Shim <kyuwon.shim@alliedtelesis.co.nz> wrote:
> The issue "core dumped" occurred  from
> ulogd_unregister_fd(). One of the processes is unlink
> from list and remove, but some struct 'pi' values
> freed without ulogd_unregister_fd().
> Unlink process needs to access the previous pointer
> value of struct 'pi', but it was already freed.
> 
> Therefore, the free() process moved location
> after finishing all ulogd_unregister_fd().

I don't understand this patch.

llist_for_each_entry_safe() doesn't dereference 'pi' after its free'd.

Where does this deref happen?  Can you share a backtrace?

> +		}
> +	}
> +
> +	llist_for_each_entry(stack, &ulogd_pi_stacks, stack_list) {
> +		llist_for_each_entry_safe(pi, npi, &stack->list, list) {
>  			free(pi);

Perhaps there should be a 'llist_del' before pi gets free'd instead?
