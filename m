Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71BF69E62A
	for <lists+netfilter-devel@lfdr.de>; Tue, 21 Feb 2023 18:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234631AbjBURo5 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 21 Feb 2023 12:44:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234469AbjBURo4 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 21 Feb 2023 12:44:56 -0500
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D51222CD
        for <netfilter-devel@vger.kernel.org>; Tue, 21 Feb 2023 09:44:55 -0800 (PST)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1pUWh9-0005r6-4D; Tue, 21 Feb 2023 18:44:51 +0100
Date:   Tue, 21 Feb 2023 18:44:51 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Xin Long <lucien.xin@gmail.com>
Cc:     netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Yuxuan Luo <luoyuxuan.carl@gmail.com>
Subject: Re: [PATCH iptables] xt_sctp: add the missing chunk types in
 sctp_help
Message-ID: <Y/UDE9nD49TmZ+jI@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Xin Long <lucien.xin@gmail.com>, netfilter-devel@vger.kernel.org,
        Florian Westphal <fw@strlen.de>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Yuxuan Luo <luoyuxuan.carl@gmail.com>
References: <dc19760b55dfa9a91171bfecc316ba1592959f27.1676999982.git.lucien.xin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc19760b55dfa9a91171bfecc316ba1592959f27.1676999982.git.lucien.xin@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Feb 21, 2023 at 12:19:42PM -0500, Xin Long wrote:
> Add the missing chunk types in sctp_help(), so that the help cmd can
> display these chunk types as below:
> 
>   # iptables -p sctp --help
> 
>   chunktypes - ... I_DATA RE_CONFIG PAD ... I_FORWARD_TSN ALL NONE
> 
> Fixes: 6b04d9c34e25 ("xt_sctp: support a couple of new chunk types")
> Signed-off-by: Xin Long <lucien.xin@gmail.com>

Patch applied, thanks!
