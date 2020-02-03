Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 070B4150E74
	for <lists+netfilter-devel@lfdr.de>; Mon,  3 Feb 2020 18:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbgBCROw (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 3 Feb 2020 12:14:52 -0500
Received: from mail4.protonmail.ch ([185.70.40.27]:61974 "EHLO
        mail4.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728910AbgBCROw (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 3 Feb 2020 12:14:52 -0500
Date:   Mon, 03 Feb 2020 17:14:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1580750091;
        bh=EzKV2LBJedlLsgQP6REJYmXH5U82UbyNhlwqs5s59aU=;
        h=Date:To:From:Reply-To:Subject:In-Reply-To:References:Feedback-ID:
         From;
        b=oQMepLrbquesfIZy4ETKAvT9WX2qMLBBNMkY8JGT/wgQBpvrbg97vbv7yP7n4gMMa
         pkqyZT6fQ0zNyL6uhiqYarD2DnrHTem9smxEdpJ3t+6XbLj0d7VhjCVrnxIysefvT+
         3dUirA8lvN7XPun2a6/pOQPqgaEw5an2tCbDOBwU=
To:     "netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>
From:   dyslexicatheist <dyslexicatheist@protonmail.com>
Reply-To: dyslexicatheist <dyslexicatheist@protonmail.com>
Subject: Re: invalid read in
Message-ID: <7BnNOPQw33ulxkwoWPovsrpwB_JPbS5nJhaTevbPCUkPRxObOpyrmqo3pFe_h82tov85DMfE1cYdX1xX3xhHNLbTef3XXmkqU26_ulUKpfY=@protonmail.com>
In-Reply-To: <20200203163152.GY19873@orbyte.nwl.cc>
References: <gwRjoIGUgI5MEgxSob7CBSUwPbYkxILRc4_ZrYWYNI7d1-T5Ej95p3XkEY_f9hLqHK5nVun7dk6RqObi0c_4482IJ6s6U33PyS6Hrm4z46E=@protonmail.com>
 <20200203163152.GY19873@orbyte.nwl.cc>
Feedback-ID: LnsYXauhtR_e9kgk2d-isThAhyxIsD2PcS0_jrp6ej-3I2WPS9tR2zudCE_YY9WCDyXkRWYo2nBz1g-cDBMDOQ==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=7.0 tests=ALL_TRUSTED,BAYES_50,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM
        shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.protonmail.ch
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Monday, February 3, 2020 4:31 PM, Phil Sutter <phil@nwl.cc> wrote:

> Hi,
>
> On Mon, Feb 03, 2020 at 01:54:31PM +0000, dyslexicatheist wrote:
>
> I guess this is the typical "problem" situation in which userspace uses
> a non-zeroed buffer to feed into sendto() and due to padding not
> every byte was written to. So basically userspace "leaks" garbage to
> kernel, which is something I'd consider harmless and merely a minor
> inconvenience when analyzing with valgrind. I usually suffer from this
> as well since libmnl()'s allocation routines don't zero the buffer
> either.
>
> In your case, I'd say the error message disappears if you add
> 'memset(&u, 0, sizeof(u))' to the beginning of nfq_set_mode().

thanks for your help Phil. I have just tried this but unfortunately it didn=
't change the outcome. Also tried other variations such as memset'ing both =
&u and the &params struct, but nada.


>
> Cheers, Phil


