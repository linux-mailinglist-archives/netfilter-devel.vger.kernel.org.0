Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB0E32CFB7
	for <lists+netfilter-devel@lfdr.de>; Thu,  4 Mar 2021 10:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237527AbhCDJcq (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 4 Mar 2021 04:32:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237539AbhCDJcf (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 4 Mar 2021 04:32:35 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D44C061574
        for <netfilter-devel@vger.kernel.org>; Thu,  4 Mar 2021 01:31:55 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1lHkKo-0007ze-8P; Thu, 04 Mar 2021 10:31:54 +0100
Date:   Thu, 4 Mar 2021 10:31:54 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Ludovic Senecaux <linuxludo@free.fr>
Cc:     pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Subject: Re: [PATCH][nft,v2] conntrack: Fix gre tunneling over ipv6
Message-ID: <20210304093154.GK17911@breakpoint.cc>
References: <20210304090959.GA301692@r1.mshome.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304090959.GA301692@r1.mshome.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Ludovic Senecaux <linuxludo@free.fr> wrote:
> This fix permits gre connections to be tracked within ip6tables rules

Acked-by: Florian Westphal <fw@strlen.de>
