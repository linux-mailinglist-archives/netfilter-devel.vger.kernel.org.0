Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6446FE312D
	for <lists+netfilter-devel@lfdr.de>; Thu, 24 Oct 2019 13:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439216AbfJXLq4 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 24 Oct 2019 07:46:56 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:34308 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726389AbfJXLqz (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 24 Oct 2019 07:46:55 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1iNbZt-0002jy-SO; Thu, 24 Oct 2019 13:46:53 +0200
Date:   Thu, 24 Oct 2019 13:46:53 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Ttttabcd <ttttabcd@protonmail.com>
Cc:     Florian Westphal <fw@strlen.de>,
        "netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>
Subject: Re: How to implement transparent proxy in bridge through nftables
Message-ID: <20191024114653.GU25052@breakpoint.cc>
References: <0nkwkdhigGlVkVliaeVhuQ2wMq-np7v0sEG1lwiwI8fKYJg8plX19uqIPiONNMpUQbIluwVsyIPsVyEs7MTE_zGRJWgaYCYdchwRs16fRHk=@protonmail.com>
 <20191022132533.GJ25052@breakpoint.cc>
 <znxWvqNmfP1aG_VCHdCfvD3KssnJIXufwOon4sm9-IEv_z9umsB1zWs8rZIduSUMgGEwjF1fy7tgI4YCy7mGPPpa2bBSg78Ww8TxiySh_5A=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <znxWvqNmfP1aG_VCHdCfvD3KssnJIXufwOon4sm9-IEv_z9umsB1zWs8rZIduSUMgGEwjF1fy7tgI4YCy7mGPPpa2bBSg78Ww8TxiySh_5A=@protonmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Ttttabcd <ttttabcd@protonmail.com> wrote:
> But there is a problem here, that is, the specified MAC address is fixed, this is not universal, I have to modify the command on different devices.

Yes.

> Is there a way for nftables to automatically get the MAC address of the interface?

Not yet, but we could extend nft/ nft_meta.c so you could do
"ether daddr set meta ifaddr" or something like that.
