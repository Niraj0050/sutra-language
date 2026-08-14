#ifndef SUTRA_RUNTIME_HPP
#define SUTRA_RUNTIME_HPP

#include "sutra/types.hpp"
#include <string>
#include <memory>
#include <iostream>
#include <cstdint>

namespace sutra {
namespace runtime {

class OSPlatform {
public:
    virtual ~OSPlatform() = default;
    virtual void console_write(const std::string& text) = 0;
    virtual std::string console_read() = 0;
    virtual std::string console_read_line() = 0;
    virtual bool file_exists(const std::string& path) = 0;
    virtual std::string file_read(const std::string& path) = 0;
    virtual void file_write(const std::string& path, const std::string& content) = 0;
    virtual std::string get_env_var(const std::string& name) = 0;
    virtual std::string get_cwd() = 0;
    virtual std::string get_platform_name() = 0;
};

class WindowsPlatform : public OSPlatform {
public:
    void console_write(const std::string& text) override;
    std::string console_read() override;
    std::string console_read_line() override;
    bool file_exists(const std::string& path) override;
    std::string file_read(const std::string& path) override;
    void file_write(const std::string& path, const std::string& content) override;
    std::string get_env_var(const std::string& name) override;
    std::string get_cwd() override;
    std::string get_platform_name() override;
};

class LinuxPlatform : public OSPlatform {
public:
    void console_write(const std::string& text) override;
    std::string console_read() override;
    std::string console_read_line() override;
    bool file_exists(const std::string& path) override;
    std::string file_read(const std::string& path) override;
    void file_write(const std::string& path, const std::string& content) override;
    std::string get_env_var(const std::string& name) override;
    std::string get_cwd() override;
    std::string get_platform_name() override;
};

class Runtime {
public:
    static Runtime& get_instance() {
        static Runtime instance;
        return instance;
    }

    void initialize(std::unique_ptr<OSPlatform> platform = nullptr);
    OSPlatform& platform() { return *m_platform; }

    void set_output_stream(std::ostream* out) { m_out_stream = out; }
    void set_input_stream(std::istream* in) { m_in_stream = in; }
    std::ostream* get_output_stream() const { return m_out_stream; }
    std::istream* get_input_stream() const { return m_in_stream; }

    void write(const std::string& text);
    void write_line(const std::string& text);
    std::string read();
    std::string read_line();

private:
    Runtime();
    std::unique_ptr<OSPlatform> m_platform;
    std::ostream* m_out_stream{&std::cout};
    std::istream* m_in_stream{&std::cin};
};

} // namespace runtime
} // namespace sutra

#endif // SUTRA_RUNTIME_HPP
