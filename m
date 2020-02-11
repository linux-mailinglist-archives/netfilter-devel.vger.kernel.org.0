Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0F4158931
	for <lists+netfilter-devel@lfdr.de>; Tue, 11 Feb 2020 05:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbgBKEm6 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 10 Feb 2020 23:42:58 -0500
Received: from mail-40131.protonmail.ch ([185.70.40.131]:40764 "EHLO
        mail-40131.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728147AbgBKEm6 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 10 Feb 2020 23:42:58 -0500
Date:   Tue, 11 Feb 2020 04:42:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
        s=default; t=1581396175;
        bh=uwxMgFi8YjyyGrFnafW9lqXd9QO2JLAMYSKMf0gwjN8=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=tTspucv42IrRmO4MuSIhrD1uPJJZrsQFxNbnQg7osQlnClbRfvXaZzyWejBze9Ag+
         PmBxQqVllx5WzGCQBhAj+mZba9J2W+wq+8f8iA10dAK6WkyxTotwikXBYZzeV6nV5E
         li9ECFH5j/hd2nlbD+pqORs6xvGJK2hSK3+hqQao=
To:     Pablo Neira Ayuso <pablo@netfilter.org>
From:   Laurent Fasnacht <fasnacht@protonmail.ch>
Cc:     "netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>
Reply-To: Laurent Fasnacht <fasnacht@protonmail.ch>
Subject: Re: [PATCH nft include v2 6/7] scanner: fix indesc_list stack to be in the correct order
Message-ID: <F1y_SmEKqhD9r5bVrMEGANbRUJN4Un3ASxI9gzrX-B1_7SCpUrBjHn4gBr_QWVyNjPK1McgRCqutBaK5lYTThqVwex5siCX08Ol4GAzPE38=@protonmail.ch>
In-Reply-To: <20200210223345.vvxnrb26ds5rhgoo@salvia>
References: <20200210101709.9182-1-fasnacht@protonmail.ch>
 <20200210101709.9182-7-fasnacht@protonmail.ch>
 <20200210223345.vvxnrb26ds5rhgoo@salvia>
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
On Monday, February 10, 2020 11:33 PM, Pablo Neira Ayuso <pablo@netfilter.o=
rg> wrote:

> On Mon, Feb 10, 2020 at 10:17:27AM +0000, Laurent Fasnacht wrote:
>
> > This fixes the location displayed in error messages.
> >
> > Signed-off-by: Laurent Fasnacht fasnacht@protonmail.ch
> >
> > -------------------------------------------------------
> >
> > src/scanner.l | 6 +++++-
> > 1 file changed, 5 insertions(+), 1 deletion(-)
> > diff --git a/src/scanner.l b/src/scanner.l
> > index 7f40c5c1..8407a2a1 100644
> > --- a/src/scanner.l
> > +++ b/src/scanner.l
> > @@ -668,7 +668,11 @@ addrstring ({macaddr}|{ip4addr}|{ip6addr})
> > static void scanner_push_indesc(struct parser_state *state,
> > struct input_descriptor *indesc)
> > {
> >
> > -   list_add_tail(&indesc->list, &state->indesc_list);
> >
> > -   if (!state->indesc) {
> > -       list_add_tail(&indesc->list, &state->indesc_list);
> >
> >
> > -   } else {
> > -       list_add(&indesc->list, &state->indesc->list);
> >
> >
> > -   }
>
> Probably belongs to patch 4/7 ?

It doesn't. Patch 4/7 is about getting rid of the static arrays in order to=
 apply the fix in patch 5/7, but doesn't modify the data structure itself.

This specific patch modifies the state->indesc_list data structure to fix t=
he stack implementation, in order to provide the correct error messages (in=
 file included from...), and is not required to fix the inclusion bug. It i=
s however to ensure that we implement a correct stack.
