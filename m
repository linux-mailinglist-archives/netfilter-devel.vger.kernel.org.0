Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0FB7353539
	for <lists+netfilter-devel@lfdr.de>; Sat,  3 Apr 2021 20:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237009AbhDCSTI (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 3 Apr 2021 14:19:08 -0400
Received: from mail.netfilter.org ([217.70.188.207]:57122 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236866AbhDCSS5 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 3 Apr 2021 14:18:57 -0400
Received: from us.es (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 1AB0163E42;
        Sat,  3 Apr 2021 20:18:36 +0200 (CEST)
Date:   Sat, 3 Apr 2021 20:18:50 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] netfilter: nftables: fix a warning message in
 nf_tables_commit_audit_collect()
Message-ID: <20210403181850.GA4976@salvia>
References: <YGcD6HO8tiX7G4OJ@mwanda>
 <CAHC9VhQ4D25kvzjXyvk8eJFXCOAaxuzUkSyNTePSrBHONxXZwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHC9VhQ4D25kvzjXyvk8eJFXCOAaxuzUkSyNTePSrBHONxXZwQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Apr 02, 2021 at 11:57:20AM -0400, Paul Moore wrote:
> On Fri, Apr 2, 2021 at 7:46 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > The first argument of a WARN_ONCE() is a condition.  This WARN_ONCE()
> > will only print the table name, and is potentially problematic if the
> > table name has a %s in it.
> >
> > Fixes: bb4052e57b5b ("audit: log nftables configuration change events once per table")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> >  net/netfilter/nf_tables_api.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Thanks Dan.
> 
> Reviewed-by: Paul Moore <paul@paul-moore.com>

Applied, thanks.
