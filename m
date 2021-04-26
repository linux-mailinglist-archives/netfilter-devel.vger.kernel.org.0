Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBD3F36AA4D
	for <lists+netfilter-devel@lfdr.de>; Mon, 26 Apr 2021 03:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbhDZB0X (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 25 Apr 2021 21:26:23 -0400
Received: from mail.netfilter.org ([217.70.188.207]:49816 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbhDZB0X (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 25 Apr 2021 21:26:23 -0400
Received: from us.es (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 4D019605A8;
        Mon, 26 Apr 2021 03:25:06 +0200 (CEST)
Date:   Mon, 26 Apr 2021 03:25:39 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>
Subject: Re: [PATCH] netfilter: nf_log_syslog: Unset bridge logger in pernet
 exit
Message-ID: <20210426012539.GA31075@salvia>
References: <20210421103421.6168-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210421103421.6168-1-phil@nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Apr 21, 2021 at 12:34:21PM +0200, Phil Sutter wrote:
> Without this, a stale pointer remains in pernet loggers after module
> unload causing a kernel oops during dereference. Easily reproduced by:
> 
> | # modprobe nf_log_syslog
> | # rmmod nf_log_syslog
> | # cat /proc/net/netfilter/nf_log

Applied, thanks.
