Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 181FD5FC1B
	for <lists+netfilter-devel@lfdr.de>; Thu,  4 Jul 2019 18:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbfGDQxt (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 4 Jul 2019 12:53:49 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:48978 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725865AbfGDQxt (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 4 Jul 2019 12:53:49 -0400
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1hj4zS-0000Uy-E7; Thu, 04 Jul 2019 18:53:46 +0200
Date:   Thu, 4 Jul 2019 18:53:46 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Stephen Suryaputra <ssuryaextr@gmail.com>,
        netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nftables v4] exthdr: doc: add support for matching IPv4
 options
Message-ID: <20190704165346.GA1628@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Stephen Suryaputra <ssuryaextr@gmail.com>,
        netfilter-devel@vger.kernel.org
References: <20190704003052.469-1-ssuryaextr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190704003052.469-1-ssuryaextr@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Pablo,

On Wed, Jul 03, 2019 at 08:30:52PM -0400, Stephen Suryaputra wrote:
> Add capability to have rules matching IPv4 options. This is developed
> mainly to support dropping of IP packets with loose and/or strict source
> route route options.

The applied version of this commit
(226a0e072d5c1edeb53cb61b959b011168c5c29a) lacks include/ipopt.h. Does
that linger in your clone somewhere? :)

Cheers, Phil
