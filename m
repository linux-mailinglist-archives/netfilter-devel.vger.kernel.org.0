Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C69AF353529
	for <lists+netfilter-devel@lfdr.de>; Sat,  3 Apr 2021 20:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbhDCSPZ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 3 Apr 2021 14:15:25 -0400
Received: from mail.netfilter.org ([217.70.188.207]:57086 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbhDCSPY (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 3 Apr 2021 14:15:24 -0400
Received: from us.es (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 8DF0E63E3E;
        Sat,  3 Apr 2021 20:15:02 +0200 (CEST)
Date:   Sat, 3 Apr 2021 20:15:17 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Firo Yang <firo.yang@suse.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH 1/2] ebtables: processing '--concurrent' beofore other
 arguments
Message-ID: <20210403181517.GA4624@salvia>
References: <20210401040741.15672-1-firo.yang@suse.com>
 <20210401040741.15672-2-firo.yang@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210401040741.15672-2-firo.yang@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

On Thu, Apr 01, 2021 at 12:07:40PM +0800, Firo Yang wrote:
> Our customer reported a following issue:
> If '--concurrent' was passed to ebtables command behind other arguments,
> '--concurrent' will not take effect sometimes; for a simple example,
> ebtables -L --concurrent. This is becuase the handling of '--concurrent'
> is implemented in a passing-order-dependent way.
> 
> So we can fix this problem by processing it before other arguments.

Would you instead make a patch to spew an error if --concurrent is the
first argument?

--concurrent has never worked unless you place it in first place
anyway.
