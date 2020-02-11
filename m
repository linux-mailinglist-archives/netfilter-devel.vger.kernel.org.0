Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48BD5158951
	for <lists+netfilter-devel@lfdr.de>; Tue, 11 Feb 2020 06:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbgBKFE0 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 11 Feb 2020 00:04:26 -0500
Received: from mail-40134.protonmail.ch ([185.70.40.134]:11083 "EHLO
        mail-40134.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728052AbgBKFEZ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 11 Feb 2020 00:04:25 -0500
Date:   Tue, 11 Feb 2020 05:04:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
        s=default; t=1581397462;
        bh=vkYDYUrBMRN8/kfD8FcLiMjwGCnkA6goCZ+C8GnTbSs=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=U2ep6a/Ivn/zfIwtMjZDVLNENN8mk1spQfF9fXaTFrUUxwbTnTymS2QGY9uE3sr5m
         zzWAQsyEWMSS4UhR2csky0TDMobr/Unt2kWHK7AW7namWz6q8M6+pciZbwjDM2L9Jg
         FyBn7EEHikfCBCUmG9y0QgDrPKouhE3t52bvFzf4=
To:     Pablo Neira Ayuso <pablo@netfilter.org>
From:   Laurent Fasnacht <fasnacht@protonmail.ch>
Cc:     netfilter-devel@vger.kernel.org
Reply-To: Laurent Fasnacht <fasnacht@protonmail.ch>
Subject: Re: [PATCH nft include v2 7/7] scanner: remove parser_state->indesc_idx
Message-ID: <5YhGob-vtZBW2TpVr0wlC1uha0ngkIOCr9Q7l02x-d2taByz2al-VOPhZ-DTMTk14YwiztBS4SoL2A2qtN9lNpe0pxdXLBAFFYHJNTAwucE=@protonmail.ch>
In-Reply-To: <20200210223153.siwzx76uhnxurkj2@salvia>
References: <20200210101709.9182-1-fasnacht@protonmail.ch>
 <20200210101709.9182-8-fasnacht@protonmail.ch>
 <20200210223153.siwzx76uhnxurkj2@salvia>
Feedback-ID: 67Kw-YMwrBchoIMLcnFuA64ZnJub6AgnNvfJUjsgbTTSp4dmymKgGy_PLLqmOsJ9F58iClONCeGYaqp9YPx84w==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=7.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.protonmail.ch
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Monday, February 10, 2020 11:31 PM, Pablo Neira Ayuso <pablo@netfilter.o=
rg> wrote:

> On Mon, Feb 10, 2020 at 10:17:28AM +0000, Laurent Fasnacht wrote:
> > static void scanner_pop_indesc(struct parser_state *state)
> > {
> >
> > -   state->indesc_idx--;
> >     if (!list_empty(&state->indesc_list)) {
> >     state->indesc =3D list_entry(state->indesc->list.prev, struct input=
_descriptor, list);
> >     } else {
> >     @@ -968,10 +966,6 @@ void scanner_destroy(struct nft_ctx *nft)
> >     {
> >     struct parser_state *state =3D yyget_extra(nft->scanner);
> >
> > -   do {
> >
> > -       yypop_buffer_state(nft->scanner);
> >
> >
>
> nft_pop_buffer_state calls free().
>
> Are you sure this can be removed without incurring in memleaks?

I'm pretty sure it can, since scanner_destroy is only called from outside o=
f the scanner itself (and I'm expecting calling that function during the pa=
rsing might break a lot things ;-).

In my understanding, any file that is being parsed should reach the end of =
file at some point, and therefore have scanner_pop_buffer called. This is t=
rue also in case of parsing errors.

I've tested that understanding by counting the number of yypush and yypop c=
alls in various cases, and by adding an assert in scanner_destroy (which co=
nsist in asserting that the "active" part of the stack is empty):

assert(state->indesc->list.next =3D=3D state->indesc_list.next);

This has succeeded both for the test suite and for the very complex rule se=
t I'm working on currently.

Just as a comment about the stack: in implementation with patch 6/7 applied=
, it consists in two parts, the active part and the "dangling tail".  The s=
tart of the stack is in state->indesc_list, and the active element (in stat=
e->indesc) is the end of the active part. All the elements in the active pa=
rt of the stack have buffer pushed. When parsing a file ends, the buffer is=
 popped and state->indesc is moved (but the input descriptor itself is not =
removed from the list, so it stays in the tail part until scanner_destroy i=
s called).
