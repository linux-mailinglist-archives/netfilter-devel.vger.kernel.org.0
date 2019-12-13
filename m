Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8C711E230
	for <lists+netfilter-devel@lfdr.de>; Fri, 13 Dec 2019 11:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbfLMKke (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 13 Dec 2019 05:40:34 -0500
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:39332 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726016AbfLMKke (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 13 Dec 2019 05:40:34 -0500
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1ifiN7-0002iP-AK; Fri, 13 Dec 2019 11:40:33 +0100
Date:   Fri, 13 Dec 2019 11:40:33 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org, phil@nwl.cc
Subject: Re: [PATCH nft] main: enforce options before commands
Message-ID: <20191213104033.GQ795@breakpoint.cc>
References: <20191213103246.260989-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191213103246.260989-1-pablo@netfilter.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> This patch turns on POSIXLY_CORRECT on the getopt parser to enforce
> options before commands. Users get a hint in such a case:
> 
>  # nft list ruleset -a
>  Error: syntax error, options must be specified before commands
>  nft list ruleset -a

FWIW i like this better than the attempt to sanitize/escape argv[].
