Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEEA7152A0A
	for <lists+netfilter-devel@lfdr.de>; Wed,  5 Feb 2020 12:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbgBELlO (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 5 Feb 2020 06:41:14 -0500
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:39396 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728284AbgBELlO (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 5 Feb 2020 06:41:14 -0500
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1izJ3Q-0001gE-00; Wed, 05 Feb 2020 12:41:12 +0100
Date:   Wed, 5 Feb 2020 12:41:11 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Daniel <tech@tootai.net>
Cc:     Netfilter list <netfilter-devel@vger.kernel.org>
Subject: Re: NFT - delete rules per interface
Message-ID: <20200205114111.GD26952@breakpoint.cc>
References: <1292e1cd-d593-b1a5-2850-3ae18bd54a6c@tootai.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1292e1cd-d593-b1a5-2850-3ae18bd54a6c@tootai.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Daniel <tech@tootai.net> wrote:
> Hello,
> 
> is there an easy way to delete rules/set/maps/... for a specific interface ?

Can you elaborate?  With exception of netdev interface, none of these
are per interface.

