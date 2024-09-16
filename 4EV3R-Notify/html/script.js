window.addEventListener('message', function(event) {
    const data = event.data;

    if (data.type === 'showNotification') {
        showNotification(data.id, data.title, data.text, data.duration, data.notifType, data.sound);
    }

    if (data.type === 'showButtons') {
        document.getElementById('button-selection').style.display = 'block';
    }
});

function showNotification(id, title, message, duration, type, sound) {
    const container = document.getElementById('notification-container');
    const notification = document.createElement('div');
    notification.classList.add('notification', type);
    notification.style.transform = 'translateX(100%)';

    const icon = document.createElement('div');
    icon.classList.add('notification-icon', type);
    notification.appendChild(icon);

    const content = document.createElement('div');
    content.classList.add('notification-content');
    content.innerHTML = `<strong>${capitalizeFirstLetter(type)}</strong><p>${message}</p>`;
    notification.appendChild(content);

    playNotificationSound(sound);
    container.appendChild(notification);

    setTimeout(() => {
        notification.style.opacity = '1';
        notification.style.transform = 'translateX(0)';
    }, 100);

    setTimeout(() => {
        notification.style.opacity = '0';
        setTimeout(() => notification.remove(), 300);
    }, duration);
}

function capitalizeFirstLetter(string) {
    return string.charAt(0).toUpperCase() + string.slice(1);
}

function playNotificationSound(sound) {
    const soundElement = document.getElementById(sound.replace('.mp3', '') + 'Sound') || document.getElementById('defaultSound');
    
    if (soundElement) {
        soundElement.play().catch(error => {
            console.error('Error playing sound:', error);
        });
    }
}

let selectedOption = null;

document.querySelectorAll('input[type="radio"]').forEach(button => {
    button.addEventListener('change', function() {
        selectedOption = this.value;
        // Make the Confirm button visible
        const confirmBtn = document.getElementById('confirm-btn');
        confirmBtn.style.visibility = 'visible';
    });
});

document.getElementById('confirm-btn').addEventListener('click', function() {
    if (selectedOption) {
        fetch(`https://4EV3R-Notify/buttonSelected`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json; charset=UTF-8'
            },
            body: JSON.stringify({
                selection: selectedOption
            })
        }).then(() => {
            // Hide the button selection UI after selection is confirmed
            document.getElementById('button-selection').style.display = 'none';
        });
    }
});



function createCircularProgressDots(dotCount = 12) {
    const dotsContainer = document.getElementById('circular-dots');
    dotsContainer.innerHTML = '';

    for (let i = 0; i < dotCount; i++) {
        const dot = document.createElement('div');
        dot.classList.add('circular-dot');
        dotsContainer.appendChild(dot);
    }
}

function updateCircularProgress(percent, dotCount = 12) {
    const dots = document.querySelectorAll('.circular-dot');
    const activeDots = Math.floor((percent / 100) * dotCount);

    dots.forEach((dot, index) => {
        if (index < activeDots) {
            dot.classList.add('active');
        } else {
            dot.classList.remove('active');
        }
    });

    document.getElementById('progress-percentage').innerText = `${percent}%`;
}

window.addEventListener('message', function(event) {
    const data = event.data;

    if (data.type === 'showCircularProgress') {
        document.getElementById('circular-progress-container').style.display = 'flex';
        createCircularProgressDots();

        let currentPercent = 0;
        const interval = setInterval(() => {
            currentPercent += 1;
            updateCircularProgress(currentPercent);

            if (currentPercent >= 100) {
                clearInterval(interval);
                setTimeout(() => {
                    document.getElementById('circular-progress-container').style.display = 'none';
                }, 500);
            }
        }, data.duration / 100);
    }
});
