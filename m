Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2E44E2B92
	for <lists+netfilter-devel@lfdr.de>; Thu, 24 Oct 2019 09:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408787AbfJXH5z (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 24 Oct 2019 03:57:55 -0400
Received: from mail-40133.protonmail.ch ([185.70.40.133]:39610 "EHLO
        mail-40133.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408770AbfJXH5z (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 24 Oct 2019 03:57:55 -0400
Date:   Thu, 24 Oct 2019 07:57:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1571903873;
        bh=3ymyhk3uYsomtMMNgSikCDz4CmHiGgYHfaWQ/cnfS+M=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=GJ8I22PuFc8VVai/5lUTf7cXJKvcrZJDcAYYwSgJ84EuY9dBWYAdl/FuO58JFn0ob
         cV2D2NvSRjl1EqJP5q1DPb4TpNiumyEzi3Fjcah4MrpRw9uDXj3KEgVEjEdQAOliR7
         qrCOyTJGYgfm88dAyprbUWdfkr1i+kXzae2TLNG0=
To:     Florian Westphal <fw@strlen.de>
From:   Ttttabcd <ttttabcd@protonmail.com>
Cc:     "netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>
Reply-To: Ttttabcd <ttttabcd@protonmail.com>
Subject: Re: How to implement transparent proxy in bridge through nftables
Message-ID: <znxWvqNmfP1aG_VCHdCfvD3KssnJIXufwOon4sm9-IEv_z9umsB1zWs8rZIduSUMgGEwjF1fy7tgI4YCy7mGPPpa2bBSg78Ww8TxiySh_5A=@protonmail.com>
In-Reply-To: <20191022132533.GJ25052@breakpoint.cc>
References: <0nkwkdhigGlVkVliaeVhuQ2wMq-np7v0sEG1lwiwI8fKYJg8plX19uqIPiONNMpUQbIluwVsyIPsVyEs7MTE_zGRJWgaYCYdchwRs16fRHk=@protonmail.com>
 <20191022132533.GJ25052@breakpoint.cc>
Feedback-ID: EvWK9os_-weOBrycfL_HEFp-ixys9sxnciOqqctCHB9kjCM4ip8VR9shOcMQZgeZ7RCnmNC4HYjcUKNMz31NBA==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=7.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_REPLYTO
        autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.protonmail.ch
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

> You can try this example from nft man page, you need to replace the mac
> address of course.
>
> bridge prerouting meta pkttype set unicast ether daddr set 00:11:22:33:44=
:55

I have been busy with other things in recent days. I didn=E2=80=99t read th=
e mail. Thank you very much.

This is very helpful. Replace the destination MAC address with the bridge i=
nterface MAC address to get the packet to the network layer.

But there is a problem here, that is, the specified MAC address is fixed, t=
his is not universal, I have to modify the command on different devices.

Is there a way for nftables to automatically get the MAC address of the int=
erface?
