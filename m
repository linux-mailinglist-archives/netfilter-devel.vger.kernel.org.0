Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF262151D5F
	for <lists+netfilter-devel@lfdr.de>; Tue,  4 Feb 2020 16:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbgBDPih (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 4 Feb 2020 10:38:37 -0500
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:36166 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727290AbgBDPih (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 4 Feb 2020 10:38:37 -0500
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1iz0Ha-0004C4-D2; Tue, 04 Feb 2020 16:38:34 +0100
Date:   Tue, 4 Feb 2020 16:38:34 +0100
From:   Florian Westphal <fw@strlen.de>
To:     =?iso-8859-15?Q?Jos=E9_M=2E?= Guisado <guigom@riseup.net>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org, netfilter@vger.kernel.org
Subject: Re: [MAINTENANCE] migrating git.netfilter.org
Message-ID: <20200204153834.GI15904@breakpoint.cc>
References: <20200131105123.dldbsjzqe6akaefr@salvia>
 <fbd79f10-0e17-a46e-32f5-e079389ac1f6@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fbd79f10-0e17-a46e-32f5-e079389ac1f6@riseup.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Jos� M. Guisado <guigom@riseup.net> wrote:
> On 31/01/2020 11:51, Pablo Neira Ayuso wrote:
> > Hi,
> > 
> > A few of our volunteers have been working hard to migrate
> > git.netfilter.org to a new server. The dns entry also has been updated
> > accordingly. Just let us know if you experience any troubles.
> > 
> > Thanks.
> 
> Great!
> 
> https://git.netfilter.org/iptables/ has been showing "Repository seems
> to be empty" for a few hours but the git url
> (git://git.netfilter.org/iptables) is working fine.

Unfortunately I don't have access to the servers so I can't do anything
about this.

Most likely the permissions are not correct and changes to the repo
make it inaccessible to gitweb.
