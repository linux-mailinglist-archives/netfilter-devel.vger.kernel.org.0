Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC2E2114C76
	for <lists+netfilter-devel@lfdr.de>; Fri,  6 Dec 2019 07:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbfLFGzI (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 6 Dec 2019 01:55:08 -0500
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:58728 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726104AbfLFGzI (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 6 Dec 2019 01:55:08 -0500
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1id7W4-0004nc-Hz; Fri, 06 Dec 2019 07:55:04 +0100
Date:   Fri, 6 Dec 2019 07:55:04 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Duncan Roe <duncan_roe@optusnet.com.au>
Cc:     pablo@netfilter.org, netfilter-devel@vger.kernel.org,
        sbezverk@cisco.com
Subject: Re: [PATCH nft v2] doc: Clarify conditions under which a reject
 verdict is permissible
Message-ID: <20191206065504.GY795@breakpoint.cc>
References: <20191203235010.GA11671@dimstar.local.net>
 <20191206023712.21119-1-duncan_roe@optusnet.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191206023712.21119-1-duncan_roe@optusnet.com.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Duncan Roe <duncan_roe@optusnet.com.au> wrote:
> A phrase like "input chain" is a throwback to xtables documentation.
> In nft, chains are containers for rules. They do have a type, but what's
> important here is which hook each uses.

Applied, thanks Duncan.
