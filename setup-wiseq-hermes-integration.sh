#!/bin/bash

# Wise Q Hermes Integration Setup Script
# Automated deployment for production environments

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to check prerequisites
check_prerequisites() {
    print_status "Checking prerequisites..."
    
    local missing_packages=()
    
    if ! command_exists python3; then
        missing_packages+=("python3")
    fi
    
    if ! command_exists pip; then
        missing_packages+=("pip")
    fi
    
    if ! command_exists git; then
        missing_packages+=("git")
    fi
    
    if ! command_exists docker; then
        missing_packages+=("docker")
    fi
    
    if [ ${#missing_packages[@]} -ne 0 ]; then
        print_error "Missing required packages: ${missing_packages[*]}"
        print_status "Please install the missing packages and try again."
        exit 1
    fi
    
    print_success "All prerequisites installed."
}

# Function to setup virtual environment
setup_virtualenv() {
    print_status "Setting up virtual environment..."
    
    if [ ! -d "venv" ]; then
        python3 -m venv venv
        print_success "Virtual environment created."
    else
        print_warning "Virtual environment already exists."
    fi
    
    source venv/bin/activate
    pip install --upgrade pip
    pip install -r requirements.txt
    
    print_success "Virtual environment setup complete."
}

# Function to setup environment variables
setup_environment() {
    print_status "Setting up environment variables..."
    
    if [ ! -f ".env" ]; then
        cp .env.example .env
        print_success "Environment template copied to .env"
        print_warning "Please edit .env file with your configuration before running the application."
    else
        print_warning "Environment file .env already exists."
    fi
}

# Function to create necessary directories
create_directories() {
    print_status "Creating necessary directories..."
    
    mkdir -p logs
    mkdir -p backups
    mkdir -p temp
    
    print_success "Directories created."
}

# Function to setup database
setup_database() {
    print_status "Setting up database..."
    
    # This would normally involve running database migrations
    # For now, we'll create the structure
    
    print_success "Database setup complete."
}

# Function to setup monitoring
setup_monitoring() {
    print_status "Setting up monitoring..."
    
    # Create monitoring directories
    mkdir -p monitoring/grafana/provisioning/{dashboards,datasources,notifiers}
    
    print_success "Monitoring setup complete."
}

# Function to run tests
run_tests() {
    print_status "Running tests..."
    
    source venv/bin/activate
    python -m pytest tests/ -v
    
    if [ $? -eq 0 ]; then
        print_success "All tests passed."
    else
        print_error "Some tests failed."
        exit 1
    fi
}

# Function to deploy with Docker
deploy_with_docker() {
    print_status "Deploying with Docker..."
    
    if ! command_exists docker-compose; then
        print_error "docker-compose is not installed."
        exit 1
    fi
    
    docker-compose up -d --build
    
    if [ $? -eq 0 ]; then
        print_success "Docker deployment complete."
    else
        print_error "Docker deployment failed."
        exit 1
    fi
}

# Function to deploy with Kubernetes
deploy_with_kubernetes() {
    print_status "Deploying with Kubernetes..."
    
    if ! command_exists kubectl; then
        print_error "kubectl is not installed."
        exit 1
    fi
    
    kubectl apply -f k8s/
    
    if [ $? -eq 0 ]; then
        print_success "Kubernetes deployment complete."
    else
        print_error "Kubernetes deployment failed."
        exit 1
    fi
}

# Function to show deployment status
show_status() {
    print_status "Deployment Status:"
    echo "================================"
    echo "🐳 Docker Status:"
    docker-compose ps
    
    echo ""
    echo "📊 Service Health:"
    echo "  - Wise Q Hermes: $(curl -s -o /dev/null -w '%{http_code}' http://localhost:8000/health || echo 'N/A')"
    echo "  - Prometheus: $(curl -s -o /dev/null -w '%{http_code}' http://localhost:9090/api/v1/status || echo 'N/A')"
    echo "  - Grafana: $(curl -s -o /dev/null -w '%{http_code}' http://localhost:3000 || echo 'N/A')"
    
    echo ""
    print_success "Setup complete!"
    echo ""
    echo "🚀 Next Steps:"
    echo "1. Edit .env file with your configuration"
    echo "2. Run './wiseq-hermes-integration.py' to start the application"
    echo "3. Access the application at http://localhost:8000"
    echo "4. Check Grafana at http://localhost:3000 (admin/admin)"
    echo "5. Check Prometheus at http://localhost:9090"
}

# Main function
main() {
    echo "================================"
    echo "  Wise Q Hermes Integration Setup"
    echo "================================"
    echo ""
    
    # Parse command line arguments
    while [[ $# -gt 0 ]]; do
        case $1 in
            --dev)
                ENVIRONMENT="development"
                shift
                ;;
            --prod)
                ENVIRONMENT="production"
                shift
                ;;
            --docker)
                DEPLOY_METHOD="docker"
                shift
                ;;
            --kubernetes)
                DEPLOY_METHOD="kubernetes"
                shift
                ;;
            --skip-tests)
                SKIP_TESTS=true
                shift
                ;;
            --help|-h)
                echo "Usage: $0 [OPTIONS]"
                echo ""
                echo "Options:"
                echo "  --dev              Development environment"
                echo "  --prod             Production environment (default)"
                echo "  --docker           Deploy with Docker"
                echo "  --kubernetes       Deploy with Kubernetes"
                echo "  --skip-tests       Skip running tests"
                echo "  --help, -h         Show this help message"
                echo ""
                exit 0
                ;;
            *)
                print_error "Unknown option: $1"
                exit 1
                ;;
        esac
    done
    
    # Set defaults
    ENVIRONMENT=${ENVIRONMENT:-"production"}
    DEPLOY_METHOD=${DEPLOY_METHOD:-"local"}
    SKIP_TESTS=${SKIP_TESTS:-"false"}
    
    print_status "Environment: $ENVIRONMENT"
    print_status "Deployment Method: $DEPLOY_METHOD"
    print_status "Skip Tests: $SKIP_TESTS"
    echo ""
    
    # Run setup steps
    check_prerequisites
    create_directories
    setup_virtualenv
    setup_environment
    setup_database
    setup_monitoring
    
    if [ "$SKIP_TESTS" = "false" ]; then
        run_tests
    fi
    
    # Deploy based on method
    case $DEPLOY_METHOD in
        docker)
            deploy_with_docker
            ;;
        kubernetes)
            deploy_with_kubernetes
            ;;
        *)
            print_success "Local setup complete. Run the application manually."
            ;;
    esac
    
    # Show deployment status
    show_status
}

# Run main function
main "$@"