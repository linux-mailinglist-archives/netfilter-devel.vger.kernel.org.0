Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1F5F214D72
	for <lists+netfilter-devel@lfdr.de>; Sun,  5 Jul 2020 17:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbgGEPLP (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 5 Jul 2020 11:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727932AbgGEPLO (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 5 Jul 2020 11:11:14 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8E3C08C5DF
        for <netfilter-devel@vger.kernel.org>; Sun,  5 Jul 2020 08:11:13 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id w6so39781144ejq.6
        for <netfilter-devel@vger.kernel.org>; Sun, 05 Jul 2020 08:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NjVTfMdZw6XwQbxDon7o4vpETM5NGTk+/7UWsjNsjd4=;
        b=yX/nMhf/TTT1hAEQCTePWhtOhrfGd8UFNU1+fpmAoISYSg+PJyyp6lGq8jXleK83FY
         6dF9ZGgs+WyvBE0QaAyku9Fe8unIvrcbAerS+AExmzg/2tpVNlWkncMbzynrDzyw/SQ/
         zp26+E8sCfXqdVOT8kB9foQtj+jQKLgAdUsbRHVI+AOPRLpy88eACwzBVU8jB5X5tYfc
         0eMKTNWLc5SqU5rsSkI8MICAAHR4tM0TjLooUvmt8/O9V0EW7klVSrlOEpTbaWL1uJ0U
         mA/VwWZPZleKlF2X/5FJfLDnnsPmbUOcIqDw1hFFD9wGUicuGQfK4Br7dQA1V+dKi7zB
         vb9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NjVTfMdZw6XwQbxDon7o4vpETM5NGTk+/7UWsjNsjd4=;
        b=rccIDLian0dBm9Yo3eixRMsxnQIptJeEsA/Zghwg8tbNccTG/q8HvfXe/fHYW4thy5
         VZw9a1zeRL40qBxBHiYsZ2QsJg5Xu3hzRpyFmEOg8KBMxfHP2KLU8a4/DwAFQs+PRFXf
         EqfJJJ+5WEm6spB1VuHaAxUF8Z7ktqHsbioxQcJ58FiXqlclraH0+t46x0RXvR6Qhay1
         hh0MNU7r1J+gEFfm1RYFXw4wjig9jIRkO8nMTCzkdoc4QqpXoGNs7ufRCpw1OSjm52Ql
         qpkN2rtR4OtYyrzUcOBNzl8dnAh4QdKnjvDy0QB4K59FyoufmLMj9ILlebiFL9+c6HTB
         9o0g==
X-Gm-Message-State: AOAM530wqXlVqQ5YZHwh437GAipCuVhLwRRtONWNGUWcBqUMlckfXxMa
        Z+UHx8b0qPNMcV8Y6w0k8v7fc1IIAILneZO/fC9Z
X-Google-Smtp-Source: ABdhPJxZNVMN4RChXVrByWzKcFP6o6O2BuhllrOjeEE1M/lyej09V/IMzWRWLsJY9AP/xCOr9AZ8/Zf2tA+G6mTWN/A=
X-Received: by 2002:a17:906:1403:: with SMTP id p3mr31517140ejc.106.1593961872347;
 Sun, 05 Jul 2020 08:11:12 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1593198710.git.rgb@redhat.com> <21e6c4e1ac179c8dcf35803e603899ccfc69300a.1593198710.git.rgb@redhat.com>
In-Reply-To: <21e6c4e1ac179c8dcf35803e603899ccfc69300a.1593198710.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 5 Jul 2020 11:11:00 -0400
Message-ID: <CAHC9VhTEkhZqkH24hPEZgMtWcYy9qKhZdoiegDLhGefa_bxmuw@mail.gmail.com>
Subject: Re: [PATCH ghak90 V9 07/13] audit: add support for non-syscall
 auxiliary records
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        sgrubb@redhat.com, Ondrej Mosnacek <omosnace@redhat.com>,
        dhowells@redhat.com, simo@redhat.com,
        Eric Paris <eparis@parisplace.org>,
        Serge Hallyn <serge@hallyn.com>, ebiederm@xmission.com,
        nhorman@tuxdriver.com, Dan Walsh <dwalsh@redhat.com>,
        mpatel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sat, Jun 27, 2020 at 9:22 AM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> Standalone audit records have the timestamp and serial number generated
> on the fly and as such are unique, making them standalone.  This new
> function audit_alloc_local() generates a local audit context that will
> be used only for a standalone record and its auxiliary record(s).  The
> context is discarded immediately after the local associated records are
> produced.

We've had some good discussions on the list about why we can't reuse
the "in_syscall" field and need to add a "local" field, I think it
would be good to address that here in the commit description.

> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> Acked-by: Serge Hallyn <serge@hallyn.com>
> Acked-by: Neil Horman <nhorman@tuxdriver.com>
> Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  include/linux/audit.h |  8 ++++++++
>  kernel/audit.h        |  1 +
>  kernel/auditsc.c      | 33 ++++++++++++++++++++++++++++-----
>  3 files changed, 37 insertions(+), 5 deletions(-)

...

> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 9e79645e5c0e..935eb3d2cde9 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -908,11 +908,13 @@ static inline void audit_free_aux(struct audit_context *context)
>         }
>  }
>
> -static inline struct audit_context *audit_alloc_context(enum audit_state state)
> +static inline struct audit_context *audit_alloc_context(enum audit_state state,
> +                                                       gfp_t gfpflags)
>  {
>         struct audit_context *context;
>
> -       context = kzalloc(sizeof(*context), GFP_KERNEL);
> +       /* We can be called in atomic context via audit_tg() */

At this point I think it's clear we need a respin so I'm not going to
preface all of my nitpick comments as such, although this definitely
would qualify ...

I don't believe audit_tg() doesn't exist yet, likely coming later in
this patchset, so please remove this comment as it doesn't make sense
in this context.

To be frank, don't re-add the comment later in the patchset either.
Comments like these tend to be fragile and don't really add any great
insight.  The audit_tg() function can, and most likely will, be
modified at some point in the future such that the comment above no
longer applies, and there is a reasonable chance that when it does the
above comment will not be updated.  Further, anyone modifying the
audit_alloc_context() is going to look at the callers (rather they
*should* look at the callers) and will notice the no-sleep
requirements.

> @@ -960,8 +963,27 @@ int audit_alloc_syscall(struct task_struct *tsk)
>         return 0;
>  }
>
> -static inline void audit_free_context(struct audit_context *context)
> +struct audit_context *audit_alloc_local(gfp_t gfpflags)
>  {
> +       struct audit_context *context = NULL;
> +
> +       context = audit_alloc_context(AUDIT_RECORD_CONTEXT, gfpflags);
> +       if (!context) {
> +               audit_log_lost("out of memory in audit_alloc_local");
> +               goto out;

You might as well just return NULL here, no need to jump and then return NULL.


> +       }
> +       context->serial = audit_serial();
> +       ktime_get_coarse_real_ts64(&context->ctime);
> +       context->local = true;
> +out:
> +       return context;
> +}
> +EXPORT_SYMBOL(audit_alloc_local);

--
paul moore
www.paul-moore.com
