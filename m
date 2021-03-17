Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58F1733FBE7
	for <lists+netfilter-devel@lfdr.de>; Thu, 18 Mar 2021 00:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhCQXjk (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 17 Mar 2021 19:39:40 -0400
Received: from mail.netfilter.org ([217.70.188.207]:49708 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbhCQXjR (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 17 Mar 2021 19:39:17 -0400
Received: from us.es (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id D755962BAB;
        Thu, 18 Mar 2021 00:39:13 +0100 (CET)
Date:   Thu, 18 Mar 2021 00:39:13 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Ludovic Senecaux <linuxludo@free.fr>
Cc:     kadlec@netfilter.org, fw@strlen.de,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Subject: Re: [PATCH][nft,v2] conntrack: Fix gre tunneling over ipv6
Message-ID: <20210317233913.GA12128@salvia>
References: <20210304090959.GA301692@r1.mshome.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210304090959.GA301692@r1.mshome.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Mar 04, 2021 at 04:10:50AM -0500, Ludovic Senecaux wrote:
> This fix permits gre connections to be tracked within ip6tables rules

Applied, thanks.
