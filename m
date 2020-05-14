Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58A801D2D88
	for <lists+netfilter-devel@lfdr.de>; Thu, 14 May 2020 12:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbgENKyZ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 14 May 2020 06:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbgENKyZ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 14 May 2020 06:54:25 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85040C061A0C
        for <netfilter-devel@vger.kernel.org>; Thu, 14 May 2020 03:54:24 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1jZBVO-0007Im-82; Thu, 14 May 2020 12:54:22 +0200
Date:   Thu, 14 May 2020 12:54:22 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Xiubo Li <xiubli@redhat.com>
Cc:     netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, kernel list <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Patrick Donnelly <pdonnell@redhat.com>
Subject: Re: netfilter: does the API break or something else ?
Message-ID: <20200514105422.GO17795@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>, Xiubo Li <xiubli@redhat.com>,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, kernel list <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Patrick Donnelly <pdonnell@redhat.com>
References: <cf0d02b2-b1db-7ef6-41b8-7c345b7d53d5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf0d02b2-b1db-7ef6-41b8-7c345b7d53d5@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

On Wed, May 13, 2020 at 11:20:35PM +0800, Xiubo Li wrote:
> Recently I hit one netfilter issue, it seems the API breaks or something 
> else.

Just for the record, this was caused by a misconfigured kernel.

Cheers, Phil
