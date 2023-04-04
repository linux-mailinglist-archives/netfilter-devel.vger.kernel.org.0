Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19CF6D6D64
	for <lists+netfilter-devel@lfdr.de>; Tue,  4 Apr 2023 21:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236225AbjDDTpD (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 4 Apr 2023 15:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236184AbjDDTo6 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 4 Apr 2023 15:44:58 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408054C1E
        for <netfilter-devel@vger.kernel.org>; Tue,  4 Apr 2023 12:44:57 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1pjmaN-0006fm-DQ; Tue, 04 Apr 2023 21:44:55 +0200
Date:   Tue, 4 Apr 2023 21:44:55 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH iptables 2/2] ebtables-nft: add broute table emulation
Message-ID: <ZCx+N9XeZgyx3KZu@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
References: <20230404094544.2892-1-fw@strlen.de>
 <20230404094544.2892-2-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404094544.2892-2-fw@strlen.de>
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Apr 04, 2023 at 11:45:44AM +0200, Florian Westphal wrote:
[...]
> --- a/iptables/ebtables-nft.8
> +++ b/iptables/ebtables-nft.8
[...]
> @@ -93,17 +96,13 @@ For the extension targets please refer to the
>  .B "TARGET EXTENSIONS"
>  section of this man page.
>  .SS TABLES
> -As stated earlier, there are two ebtables tables in the Linux
> -kernel.  The table names are
> -.BR filter " and " nat .
> -Of these two tables,
> +As stated earlier, the table names are
> +.BR filter ", " nat " and " broute .
> +Of these tables,
>  the filter table is the default table that the command operates on.
> -If you are working with the filter table, then you can drop the '-t filter'
> -argument to the ebtables command.  However, you will need to provide
> -the -t argument for
> -.B nat
> -table.  Moreover, the -t argument must be the
> -first argument on the ebtables command line, if used. 
> +If you are working with the a table other than filter, you will need to provide

Typo here ("the a" -> "a").

Also this patch broke
iptables/tests/shell/testcases/ebtables/0001-ebtables-basic_0
("broute" table name did not fail anymore, so nothing serious).

Folded both fixes into this commit, then applied the series.

Thanks for working on it!
