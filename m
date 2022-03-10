Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B91CA4D47A0
	for <lists+netfilter-devel@lfdr.de>; Thu, 10 Mar 2022 14:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241982AbiCJNF2 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 10 Mar 2022 08:05:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232078AbiCJNF2 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 10 Mar 2022 08:05:28 -0500
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5BA131128
        for <netfilter-devel@vger.kernel.org>; Thu, 10 Mar 2022 05:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
        s=mail2022; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Oa+GNfZfIrRmc7o0hHzlhG1yxxtl+LRUlb9Q8ooGykY=; b=ijgG/dpBh42h63lyUPNBPm8Zb8
        T/BDjvjd/r4dHNmSG2YQQbGvQvR6nu+uJDmK9h52v8Rn7R4jcXiN91Q+76yvqS9bM/mVMgYjBAPWU
        x9BA+h4HkhvGPiBwecpN33CVYEtdNpkMmrrVOnOSMlGrEyd6yedhvIzJbCwb3ycBKMJl7j6aUbdoG
        oxPuOclQJb680sfyld7Yh5ZmDIwoB1+qssbsYJefsqPjMLqL+6uc40IyTKTdbX3sPNwZ49WAPDcwx
        lEPzsDe6RJDCwU7fuLk+X+oGaHKn0/jnRWMLBLdC99QSwJ7F2sOfkP/FE8lo6zkoz3c/MFsOxgGC/
        brje9W7g==;
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <phil@nwl.cc>)
        id 1nSISu-0001K1-Mp; Thu, 10 Mar 2022 14:04:24 +0100
Date:   Thu, 10 Mar 2022 14:04:24 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Florian Westphal <fw@strlen.de>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
Subject: Re: [iptables RFC 1/2] libxtables: Implement notargets hash table
Message-ID: <Yin3WNl2SbiCP/+t@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20220304131944.30801-1-phil@nwl.cc>
 <20220304131944.30801-2-phil@nwl.cc>
 <20220310121748.GA13772@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310121748.GA13772@breakpoint.cc>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Mar 10, 2022 at 01:17:48PM +0100, Florian Westphal wrote:
> Phil Sutter <phil@nwl.cc> wrote:
> > +static void notargets_hlist_insert(const char *name)
> > +{
> > +	struct notarget *cur;
> > +
> > +	if (!name)
> > +		return;
> > +
> > +	cur = xtables_malloc(sizeof(*cur) + strlen(name) + 1);
> > +	cur->name[0] = '\0';
> > +	strcat(cur->name, name);
> 
> strcpy seems more readable than strcat here.

Oh, indeed. Looks like an old attempt at avoiding strncpy() compiler
warnings. ;)

Thanks, Phil
