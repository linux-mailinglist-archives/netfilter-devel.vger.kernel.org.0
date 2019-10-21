Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 151F3DED83
	for <lists+netfilter-devel@lfdr.de>; Mon, 21 Oct 2019 15:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbfJUN16 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 21 Oct 2019 09:27:58 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:45058 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728017AbfJUN16 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 21 Oct 2019 09:27:58 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1iMXj1-0004E9-Kj; Mon, 21 Oct 2019 15:27:55 +0200
Date:   Mon, 21 Oct 2019 15:27:55 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Phil Sutter <phil@nwl.cc>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>
Subject: Re: [iptables PATCH v2] xtables-restore: Fix --table parameter check
Message-ID: <20191021132755.GE25052@breakpoint.cc>
References: <20191021132324.11039-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021132324.11039-1-phil@nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Phil Sutter <phil@nwl.cc> wrote:
> Xtables-restore tries to reject rule commands in input which contain a
> --table parameter (since it is adding this itself based on the previous
> table line). The manual check was not perfect though as it caught any
> parameter starting with a dash and containing a 't' somewhere, even in
> rule comments:
> 
> | *filter
> | -A FORWARD -m comment --comment "- allow this one" -j ACCEPT
> | COMMIT
> 
> Instead of error-prone manual checking, go a much simpler route: All
> do_command callbacks are passed a boolean indicating they're called from
> *tables-restore. React upon this when handling a table parameter and
> error out if it's not the first one.
> 
>  			if (cs.invert)
>  				xtables_error(PARAMETER_PROBLEM,
>  					   "unexpected ! flag before --table");
> +			if (restore && *table)
> +				xtables_error(PARAMETER_PROBLEM,
> +					      "The -t option (seen in line %u) cannot be used in %s.\n",
> +					      line, xt_params->program_name);

Oh, thats much better indeed.

Acked-by: Florian Westphal <fw@strlen.de>
