Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 801E35E2B9
	for <lists+netfilter-devel@lfdr.de>; Wed,  3 Jul 2019 13:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbfGCLSH (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 3 Jul 2019 07:18:07 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:48110 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725820AbfGCLSH (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 3 Jul 2019 07:18:07 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1hidH4-0003dh-4V; Wed, 03 Jul 2019 13:18:06 +0200
Date:   Wed, 3 Jul 2019 13:18:06 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Stefan Laufmann <stefan.laufmann@emlix.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: Ease usage of libnetfilter_log with C++ applications
Message-ID: <20190703111806.qtygttpa34dmfghp@breakpoint.cc>
References: <784d6af7-9530-f2f3-6c46-5ae989b82838@emlix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <784d6af7-9530-f2f3-6c46-5ae989b82838@emlix.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Stefan Laufmann <stefan.laufmann@emlix.com> wrote:
> I just recently came across libnetfilter_log and used it inside a C++
> application. When compiling/linking the project I ran into problems and
> discovered that libnetfilter_log in contrast to e.g. libnetfilter_queue and
> libnetfilter_conntrack lacks `extern "C"` statements in the header files.
> 
> Are their reasons for that?

Noone sent a patch to add them.
