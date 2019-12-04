Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88446113565
	for <lists+netfilter-devel@lfdr.de>; Wed,  4 Dec 2019 20:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbfLDTFm (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 4 Dec 2019 14:05:42 -0500
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:51878 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728114AbfLDTFm (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 4 Dec 2019 14:05:42 -0500
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1icZy1-00070q-4g; Wed, 04 Dec 2019 20:05:41 +0100
Date:   Wed, 4 Dec 2019 20:05:41 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Arturo Borrero Gonzalez <arturo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH 1/7] iptables: install iptables-apply script and
 manpage
Message-ID: <20191204190541.GV795@breakpoint.cc>
References: <157548347377.125234.12163057581146113349.stgit@endurance>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157548347377.125234.12163057581146113349.stgit@endurance>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Arturo Borrero Gonzalez <arturo@netfilter.org> wrote:
> From: Laurence J. Lane <ljlane@debian.org>
> 
> We have the iptables-apply script in the tree (and in the release tarball), but
> is not being installed anywhere. Same for the manpage.
> 
> Arturo says:
>  I'm not a strong supporter of this script, but there are many users of it, so
>  better do things right and do a proper installation.
>  This patch is forwarded from the iptables Debian package, where it has been
>  around for many years now.

Series looks good to me, thanks Arturo.  Feel free to push this out.
